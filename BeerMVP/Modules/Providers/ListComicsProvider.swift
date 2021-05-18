//
//  ListComicsProvider.swift
//  PruebaMarvel
//
//  Created by Andres Felipe Ocampo Eljaiek on 19/4/21.
//

import Foundation

protocol ListComicsProviderProtocol: class {
    func fetchListBeers(completionSuccess: @escaping ([BeerServerModelElement]?) -> Void, failure: @escaping(CustomErrorModel?) -> Void)
}

class ListComicsProvider: NativeManager, ListComicsProviderProtocol {

    internal func fetchListBeers(completionSuccess: @escaping ([BeerServerModelElement]?) -> Void, failure: @escaping(CustomErrorModel?) -> Void) {

        _ = self.request(CustomRequest(method: .get,
                                       urlContext: .webService,
                                       endpoint: URLEndpoint.endpointBeers,
                                       params: nil,
                                       acceptType: AcceptResponseType.json),
                         type: [BeerServerModelElement].self) { [weak self] (result) in
            guard self != nil else { return }
            completionSuccess(result)
        } failure: { (error) in
            failure(error)
        }
    }

}
