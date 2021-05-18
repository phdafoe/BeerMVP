//  CustomErrorModel.swift
//  Architecture MVP
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation

public struct HTTPClientError: Error {
    var type: ErrorType = .unknownError

    enum ErrorType: Int {
        case internalServerError = 500
        case badGateway = 502
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case preConditionFailed = 412
        case networkError = 0
        case unknownError = -1
    }

    init(code: Int) {
        type = ErrorType(rawValue: code) ?? .unknownError
    }
}

public struct BackendError: Error {
    var type: ErrorType = .unknownError
    var code: String = ""
    var serverMessage = ""

    enum ErrorType: String {
        case invalidToken = "AUTH"
        case unknownError = ""
        case parsing = "Parsing"
    }

    init(code: String, serverMessage: String) {
        type = ErrorType(rawValue: code) ?? .unknownError
        self.serverMessage = serverMessage
    }
}

class CustomErrorModel: NSError {
	var type: String = "Backend"
	var internalCode: String = ""
	var originalObject: Any?

	var httpClientError = HTTPClientError(code: -1)
	var backendError = BackendError(code: "", serverMessage: "")

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	init(httpClientError: HTTPClientError.ErrorType, backendError: BackendError.ErrorType) {
		self.httpClientError = HTTPClientError(code: httpClientError.rawValue)
		self.backendError = BackendError(code: backendError.rawValue, serverMessage: "")
		let defaultDomain = "error_generic_description"

		super.init(domain: defaultDomain, code: self.httpClientError.type.rawValue, userInfo: nil)
	}

	init(data: Data?, httpCode: Int?) {
		httpClientError = HTTPClientError(code: httpCode ?? -1)

		let defaultDomain = "error_generic_description"
		let defaultCode = httpClientError.type.rawValue

        guard data != nil else {
			super.init(domain: defaultDomain, code: defaultCode, userInfo: nil)
			return
		}

		super.init(domain: defaultDomain, code: defaultCode, userInfo: nil)
	}
}
