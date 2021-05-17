//
//  TableViewManager.swift
//  PruebaMarvel
//
//  Created by Andres Felipe Ocampo Eljaiek
//

import Foundation
import UIKit

enum TableType {
    case unspecified
}

class TableViewManager: NSObject {
    
    weak var tableView: UITableView?
    weak var presenter: TablePresenterProtocol?
    var tableType = TableType.unspecified
    
    init(tableType: TableType = .unspecified,
         tableView: UITableView?,
         presenter: Any?) {
        super.init()
        
        self.tableType = tableType
        self.tableView = tableView
        self.presenter = presenter as? TablePresenterProtocol
        self.presenter?.tablePresenterDelegate = self
        
        self.setup()
    }
    
    func setup() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.clipsToBounds = true
        self.tableView?.separatorStyle = .none
        self.tableView?.separatorColor = UIColor.white
        self.tableView?.separatorInset = .zero
        self.tableView?.showsVerticalScrollIndicator = false
        self.tableView?.keyboardDismissMode = .interactive
        self.tableView?.tableFooterView = UIView(frame: .zero)
        self.tableView?.estimatedRowHeight = 44
        self.tableView?.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView?.rowHeight = UITableView.automaticDimension
    }
}

extension TableViewManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfCells(self.tableType, section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CommonFactoryCells.cell(for: self.presenter?.object(self.tableType, indexPath: indexPath), tableView: tableView, presenter: self.presenter)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didTapRow(self.tableType, indexPath: indexPath)
    }
}

extension TableViewManager: TablePresenterDelegate {
    
    func dataSourceUpdated() {
        self.tableView?.reloadData()
    }
}
