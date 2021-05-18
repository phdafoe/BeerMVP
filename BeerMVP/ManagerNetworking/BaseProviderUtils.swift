//  BaseProviderUtils.swift
//  Architecture MVP
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation

class BaseProviderUtils {

	static let dateFormat = "dd/MM/yyyy-HH:mm:ss"

	static func printRequest(_ customRequest: CustomRequest) {
		let data = customRequest.arrayParams != nil
			? try? JSONSerialization.data(withJSONObject: customRequest.arrayParams ?? [:], options: .prettyPrinted)
			: try? JSONSerialization.data(withJSONObject: customRequest.params ?? [], options: .prettyPrinted)

		Utils.print("************* REQUEST **************")
		Utils.print("Request Date: \(Date().format(format: dateFormat))")
		Utils.print("URL: \(customRequest.fullEndpoint)")
		if customRequest.additionalConfiguration.printLog {
			Utils.print("PARAMETERS: ")
			Utils.print(String(data: data ?? Data(), encoding: .utf8) ?? "")
			Utils.print("HEADERS: \(customRequest.headers)")
		}
		Utils.print("************* END *************")
	}

	static func printSuccessResponse(endpoint: String, data: Data, decryptedBytes: Data?, printData: Bool) {
		Utils.print("*************************** RESPONSE ***************************")
		Utils.print("Response Date: \(Date().format(format: dateFormat))")
		Utils.print("URL: \(endpoint)")
		if printData {
			Utils.print(String(data: data, encoding: .utf8) ?? "")
			Utils.print(String(data: decryptedBytes ?? Data(), encoding: .utf8) ?? "")
		}

		Utils.print("********* END ***********")
	}

	static func printFailureResponse(endpoint: String, data: Data?, decryptedBytes: Data?, printData: Bool) {
		Utils.print("*************************** RESPONSE ***************************")
		Utils.print("Response Date: \(Date().format(format: dateFormat))")
		Utils.print("URL: \(endpoint)")

		if printData {
			Utils.print(String(data: data ?? Data(), encoding: .utf8) ?? "")
			Utils.print(String(data: decryptedBytes ?? Data(), encoding: .utf8) ?? "")
		}
	}

	static func getData(name: String, withExtension: String = "json", forClass: AnyClass) -> Data? {
		let bundle = Bundle(for: forClass)
		let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
		let data = try? Data(contentsOf: fileUrl!)
		return data
	}

}
