//
//  ListComicsViewController.swift
//  PruebaMarvel
//
//  Created by Andres Felipe Ocampo Eljaiek
//

import UIKit

protocol ListComicsViewPresenterInterface: class {

}

class ListComicsViewController: BaseViewController<ListComicsPresenterProtocolOutput>, ReuseIdentifierInterfaceViewController {

    @IBOutlet weak var myTableView: UITableView!
    var tableViewManager: TableViewManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beers"
        self.tableViewManager = TableViewManager(tableView: self.myTableView, presenter: self.presenter)
        self.presenter?.loadComics()
    }

}

extension ListComicsViewController: ListComicsViewPresenterInterface {

}
