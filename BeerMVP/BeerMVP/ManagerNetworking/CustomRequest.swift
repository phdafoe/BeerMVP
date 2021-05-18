//  CustomRequest.swift
//  Architecture MVP
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation

// MARK: - AcceptResponseType
enum AcceptResponseType {
	case json
	case pdf
	case xml
	case text
}

// MARK: - HTTPMethod
public enum HTTPMethod: String {
	case options = "OPTIONS"
	case get = "GET"
	case head = "HEAD"
	case post = "POST"
	case put = "PUT"
	case patch = "PATCH"
	case delete = "DELETE"
	case trace = "TRACE"
	case connect = "CONNECT"
}

// MARK: - CustomRequest
class CustomRequest {

	var method: HTTPMethod
	var urlContext: URLEndpoint.BaseURLContext
	var endpoint: String
	var fullEndpoint: String {
		let baseURL = URLEndpoint.getBaseUrl(urlContext: urlContext)
		return "\(baseURL)/\(endpoint)"
	}
	var headers: [String: String] = [:]
	var params: [String: Any]?
	var arrayParams: [[String: Any]]?
	var acceptType = AcceptResponseType.json

	var additionalConfiguration: AdditionalConfiguration = AdditionalConfiguration()

	init() {
		method = .get
		urlContext = .backend
		endpoint = ""
	}

	init(method: HTTPMethod,
		 urlContext: URLEndpoint.BaseURLContext,
		 endpoint: String,
		 headers: [String: String] = [:],
		 params: [String: Any]?,
		 acceptType: AcceptResponseType = AcceptResponseType.json,
		 additionalConfiguration: AdditionalConfiguration = AdditionalConfiguration()) {

		self.method = method
		self.urlContext = urlContext
		self.endpoint = endpoint
		self.headers = headers
		self.params = params
		self.acceptType = acceptType
		self.additionalConfiguration = additionalConfiguration

		// self.addHeaders(Utils.getHeadersFromContext(urlContext))
	}

	init(method: HTTPMethod,
		 urlContext: URLEndpoint.BaseURLContext,
		 endpoint: String,
		 headers: [String: String] = [:],
		 arrayParams: [[String: Any]]?,
		 acceptType: AcceptResponseType = AcceptResponseType.json,
		 additionalConfiguration: AdditionalConfiguration = AdditionalConfiguration()) {

		self.method = method
		self.urlContext = urlContext
		self.endpoint = endpoint
		self.headers = headers
		self.arrayParams = arrayParams
		self.acceptType = acceptType
		self.additionalConfiguration = additionalConfiguration

		// self.addHeaders(Utils.getHeadersFromContext(urlContext))
	}

	func addHeaders(_ newHeaders: [String: String]) {
		var headers = self.headers
		headers.merge(newHeaders) { (_, new) in new}
		self.headers = headers
	}
}

extension CustomRequest {
	struct AdditionalConfiguration {

		var timeout: TimeInterval = 15
		var printLog = true
		var encrypted = false
		var authenticated = false

		init(timeout: TimeInterval = 15, printLog: Bool = true, encrypted: Bool = false, authenticated: Bool = false) {

			self.timeout = timeout
			self.printLog = printLog
			self.encrypted = encrypted
			self.authenticated = authenticated
		}
	}
}

public enum Environment: Int {
    case PRO = 0
}

// MARK: - URLEndpoint
struct URLEndpoint {

    static let environementDefault: Environment = Environment.PRO

    public enum BaseURLContext {
        case backend
        case webService
    }

    static var endpointBeers = "beers"
    // static var endpointComics = "comics"
    // static var endpointSeries = "series"
    // static var endpointStories = "stories"
}

// MARK: - extension - URLEndpoint
extension URLEndpoint {

    static func getBaseUrl(urlContext: BaseURLContext) -> String {
        switch urlContext {
        case .backend:
            return "my backend service"
        case .webService:
            return "https://api.punkapi.com/v2"
        }
    }

    static private func getBackendURL() -> String {
        switch environementDefault {
        case .PRO:
            return "https://api.punkapi.com/v2"
        }
    }

    static func buildURL(urlContext: BaseURLContext, endpoint: String) -> String {
        return getBaseUrl(urlContext: urlContext) + endpoint
    }
}
