//
//  SearchProvider.swift
//  BeerMVP
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/5/21.
//

import Foundation

protocol SearchProviderProtocol: class {
    func fetchListBeersWithParameters(completionSuccess: @escaping ([BeerServerModelElement]?) -> Void, failure: @escaping(CustomErrorModel?) -> Void)
}

class SearchProvider: NativeManager, SearchProviderProtocol {

    internal func fetchListBeersWithParameters(completionSuccess: @escaping ([BeerServerModelElement]?) -> Void, failure: @escaping(CustomErrorModel?) -> Void) {

        _ = self.request(CustomRequest(method: .get,
                                       urlContext: .webService,
                                       endpoint: URLEndpoint.endpointBeers,
                                       params: ["page": "1", "per_page": "10"],
                                       acceptType: AcceptResponseType.json),
                         type: [BeerServerModelElement].self) { [weak self] (result) in
            guard self != nil else { return }
            completionSuccess(result)
        } failure: { (error) in
            failure(error)
        }
    }

}
