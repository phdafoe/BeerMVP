//
//  TablePresenterProtocol.swift
//  PruebaMarvel
//
//  Created by Andres Felipe Ocampo Eljaiek
//

import Foundation

// Protocol used to the View can communicate with Presenter
protocol TablePresenterProtocol: class {

    var tablePresenterDelegate: TablePresenterDelegate? { get set }

    func numberOfCells(_ tableType: TableType, section: Int) -> Int
    func object(_ tableType: TableType, indexPath: IndexPath) -> Any
    func didTapRow(_ tableType: TableType, indexPath: IndexPath)
}

extension TablePresenterProtocol {

    func didTapRow(_ tableType: TableType, indexPath: IndexPath) {}
}

protocol TablePresenterDelegate: class {
    func dataSourceUpdated()
}
