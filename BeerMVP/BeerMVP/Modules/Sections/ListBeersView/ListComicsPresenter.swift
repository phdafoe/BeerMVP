//
//  ListComicsPresenter.swift
//  PruebaMarvel
//
//  Created by Andres Felipe Ocampo Eljaiek
//

import Foundation

protocol ListComicsPresenterProtocolOutput: class {
    func loadComics()
}

final class ListComicsPresenter: BasePresenter<ListComicsViewController, ListComicsRouterProtocolOutput> {
    
    var provider: ListComicsProviderProtocol!
    
    var arrayBeerViewModel: [BeerViewModel] = []
    weak var tablePresenterDelegate: TablePresenterDelegate?
 
}

extension ListComicsPresenter: ListComicsPresenterProtocolOutput {
    
    internal func loadComics() {
        self.viewController?.showLoading(view: (self.viewController?.view)!, animated: true)
        self.provider.fetchListBeers { [weak self] (result) in
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
        self.tablePresenterDelegate?.dataSourceUpdated()
    }
    
}

extension ListComicsPresenter: TablePresenterProtocol {
    
    func numberOfCells(_ tableType: TableType, section: Int) -> Int {
        return self.arrayBeerViewModel.count
    }
    
    func object(_ tableType: TableType, indexPath: IndexPath) -> Any {
        self.arrayBeerViewModel[indexPath.row]
    }
  
}

