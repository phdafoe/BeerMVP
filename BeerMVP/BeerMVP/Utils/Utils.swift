//  Utils.swift.swift
//  Architecture MVP
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation
import UIKit
import SystemConfiguration

// MARK: - ApiError
enum APIError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fecth data"
        case .invalidEndpoint: return "Invalid enpoint"
        case .invalidResponse: return "Invalild response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

// MARK: - RequestData
struct RequestData {
    var params: [String: Any]?
    var arrayParams: [[String: Any]]?
    var method: HTTPMethod
    var urlContext: URLEndpoint.BaseURLContext
    var endpoint: String
    var acceptType = AcceptResponseType.json

    init(params: [String: Any]?,
         method: HTTPMethod,
         urlContext: URLEndpoint.BaseURLContext,
         endpoint: String,
         acceptType: AcceptResponseType = .json) {

        self.params = params
        self.method = method
        self.urlContext = urlContext
        self.endpoint = endpoint
        self.acceptType = acceptType
    }

    init(arrayParams: [[String: Any]]?,
         method: HTTPMethod,
         endpoint: String,
         urlContext: URLEndpoint.BaseURLContext,
         acceptType: AcceptResponseType = .json) {

        self.arrayParams = arrayParams
        self.method = method
        self.urlContext = urlContext
        self.endpoint = endpoint
        self.acceptType = acceptType
    }
}

class Utils {
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
            var idx = items.startIndex
            let endIdx = items.endIndex
            repeat {
                Swift.print(items[idx], separator: separator, terminator: idx == (endIdx - 1) ? terminator : separator)
                idx += 1
            } while idx < endIdx
        #endif
    }
}

class Helpers {

    struct Colores {
        let GRIS_BARRA_NAVEGACION = #colorLiteral(red: 0.2549019608, green: 0.2745098039, blue: 0.3019607843, alpha: 1)
        let GRAY_NAV = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        let BLANCO_TEXTO_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let RED_ICON = #colorLiteral(red: 0.8889052868, green: 0.1445426047, blue: 0.1411617994, alpha: 1)
    }
    
    struct Constants {
        static let jsonMIMEtype = "application/json"
        static let pdfMIMEtype = "application/pdf"
        static let jpegtype = "image/jpeg"
        static let userTokenHeader = "userToken"
        static let languageHeader = "X-lang"
        static let flowTokenHeader = "token"
        static let flowTypeHeader = "FlowType"
        static let contentTypeHeader = "Content-Type"
        static let dateFormat = "yyyy-MM-dd HH:mm:ss"
        static let presentationDateFormat = "dd/MM/yyyy"
        static let paqbookPresentationDateFormat = "dd MMM yyyy"
    }
}

public protocol ReuseIdentifierProtocol : class {
    static var defaultReuseIdentifier : String{get}
}

public protocol ReuseIdentifierInterfaceViewController : class{
    static var defaultReuseIdentifierViewController : String {get}
}

public extension ReuseIdentifierProtocol where Self : UIView {
    static var defaultReuseIdentifier : String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

public extension ReuseIdentifierInterfaceViewController where Self : UIViewController{
    static var defaultReuseIdentifierViewController : String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

protocol BaseProviderParamsDTO: Codable {}

extension BaseProviderParamsDTO {
    func encode() -> [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        else { return nil }

        return json
    }
}

extension Array where Element: BaseProviderParamsDTO {
    func encode() -> [[String: Any]]? {
        guard let jsonData = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
        else { return nil }

        return json
    }
}
