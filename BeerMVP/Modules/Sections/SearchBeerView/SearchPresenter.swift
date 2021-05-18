//
//  SearchPresenter.swift
//  BeerMVP
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/5/21.
//

import Foundation

protocol SearchPresenterProtocolOutput: class {
    func loadBeers()
    func getNumberOfRowInsections() -> Int?
    func setObjectInTableView(indexPath: Int) -> BeerViewModel?
    var arrayBeerViewModel: [BeerViewModel] { get }
}

final class SearchPresenter: BasePresenter<SearchViewController, SearchRouterProtocolOutput> {

    var provider: SearchProviderProtocol!

    var arrayBeerViewModel: [BeerViewModel] = []
    //weak var tablePresenterDelegate: TablePresenterDelegate?

}

extension SearchPresenter: SearchPresenterProtocolOutput {

    internal func loadBeers() {
        self.viewController?.showLoading(view: (self.viewController?.view)!, animated: true)
        self.provider.fetchListBeersWithParameters { [weak self] (result) in
            guard let self = self else { return }
            if let resultDes = result {
                self.updateContent(businessModel: resultDes)
                self.viewController?.hideLoading(view: (self.viewController?.view)!, animated: true)
            }
        } failure: { (error) in
            print(error?.httpClientError as Any)
        }
    }

    private func updateContent(businessModel: [BeerServerModelElement]) {
        arrayBeerViewModel.removeAll()
        arrayBeerViewModel = businessModel.map { BeerViewModel(viewModel: $0 )}
        self.viewController?.reloadData()
    }
    
    func getNumberOfRowInsections() -> Int? {
        return arrayBeerViewModel.count
    }
        
    func setObjectInTableView(indexPath: Int) -> BeerViewModel? {
        return arrayBeerViewModel[indexPath]
    }

}

//extension SearchPresenter: TablePresenterProtocol {
//
//    func numberOfCells(_ tableType: TableType, section: Int) -> Int {
//        return self.arrayBeerViewModel.count
//    }
//
//    func object(_ tableType: TableType, indexPath: IndexPath) -> Any {
//        self.arrayBeerViewModel[indexPath.row]
//    }
//
//}
