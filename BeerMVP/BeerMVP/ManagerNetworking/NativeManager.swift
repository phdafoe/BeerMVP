//  NativeManager.swift
//  Architecture MVP
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation

protocol RequestManager {
    func request<D: Decodable>(_ customRequest: CustomRequest, type: D.Type, success: @escaping (D) -> Void, failure: @escaping (CustomErrorModel) -> Void) -> URLSessionTask?
}

class NativeManager: RequestManager {
	
    var requestHttpHeaders = RestEntity()
    var urlQueryParameters = RestEntity()
    var httpBodyParameters = RestEntity()

    func request<D: Decodable>(_ customRequest: CustomRequest, type: D.Type, success: @escaping (D) -> Void, failure: @escaping (CustomErrorModel) -> Void) -> URLSessionTask? {

		let endpoint = customRequest.fullEndpoint

		for currentHeader in customRequest.headers {
			requestHttpHeaders.add(value: currentHeader.value, forKey: currentHeader.key)
		}

		var targetURL = URL(string: endpoint)

		if let params = customRequest.params {
			for param in params {
				let value: String = (param.value as? String) ?? "\(param.value)"

				if customRequest.method == .get {
					urlQueryParameters.add(value: value, forKey: param.key)
					targetURL = addURLQueryParameters(toURL: URL(string: endpoint)!)
				} else {
					httpBodyParameters.add(value: value, forKey: param.key)
				}
			}
		}

		let httpBody: Data? = customRequest.method != .get ? getHttpBody(params: customRequest.params) : nil
		guard let request = prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: customRequest.method) else {
			failure(CustomErrorModel(httpClientError: .unknownError, backendError: .unknownError))
			return nil
		}


		let sessionConfiguration = URLSessionConfiguration.default
		let session = URLSession(configuration: sessionConfiguration)
        BaseProviderUtils.printRequest(customRequest)
		let task = session.dataTask(with: request) { data, response, error in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    if (200 ..< 300).contains(httpResponse.statusCode){
                        if let dataDes = data {
                            do {
                                let decodeResponse = try JSONDecoder().decode(D.self, from: dataDes)
                                DispatchQueue.main.async {
                                    BaseProviderUtils.printSuccessResponse(endpoint: customRequest.fullEndpoint, data: dataDes, decryptedBytes: nil, printData: customRequest.additionalConfiguration.printLog)
                                    success(decodeResponse)
                                }
                            } catch {
                                BaseProviderUtils.printFailureResponse(endpoint: customRequest.fullEndpoint, data: dataDes, decryptedBytes: nil, printData: true)
                                failure(CustomErrorModel(httpClientError: .notFound, backendError: .unknownError))
                            }
                        }
                    }
                }
            } else {
                failure(CustomErrorModel(httpClientError: .notFound, backendError: .unknownError))
            }
		}
		task.resume()
		return task
	}

	
}

extension NativeManager {
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
            var queryItems = [URLQueryItem]()
            if urlComponents.queryItems == nil {
                urlComponents.queryItems = queryItems
            }

            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))

                queryItems.append(item)
                urlComponents.queryItems?.append(item)
            }

            guard let updatedURL = urlComponents.url else { return url }
            return updatedURL
        }

        return url
    }

    private func getHttpBody(params: [String: Any]? = nil) -> Data? {
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") as? String else { return nil }

        if contentType.contains("application/json") {
            if let params = params {
                if #available(iOS 11.0, *) {
                    return try? JSONSerialization.data(withJSONObject: params, options: [.prettyPrinted, .sortedKeys])
                } else {
                    return nil
                }
            } else {
                if #available(iOS 11.0, *) {
                    let body = try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys])
                    return body
                } else {
                    return nil
                }
            }

        } else if contentType.contains("application/x-www-form-urlencoded") {
            let bodyString = httpBodyParameters.allValues().map { "\($0)=\(String(describing: "\($1)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))" }.joined(separator: "&")
            return bodyString.data(using: .utf8)
        } else {
            return nil
        }
    }

    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HTTPMethod) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue("\(value)", forHTTPHeaderField: header)
        }

        request.httpBody = httpBody
        return request
    }

    struct RestEntity {
        private var values: [String: Any] = [:]

        mutating func add(value: Any, forKey key: String) {
            values[key] = value
        }

        func value(forKey key: String) -> Any? {
            return values[key]
        }

        func allValues() -> [String: Any] {
            return values
        }

        func totalItems() -> Int {
            return values.count
        }
    }
}
