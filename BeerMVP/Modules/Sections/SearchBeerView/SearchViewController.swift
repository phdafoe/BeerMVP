//
//  SearchViewController.swift
//  BeerMVP
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/5/21.
//

import UIKit

protocol SearchViewPresenterInterface: class {
    func reloadData()
}

class SearchViewController: BaseViewController<SearchPresenterProtocolOutput>, ReuseIdentifierInterfaceViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var beers: [BeerViewModel] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredBeers: [BeerViewModel] = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchView()
        setupTableView()
        self.presenter?.loadBeers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = myTableView.indexPathForSelectedRow {
            myTableView.deselectRow(at: indexPath, animated: true)
        }
    }

    private func setupTableView() {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: SearchViewCell.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: SearchViewCell.defaultReuseIdentifier)
    }
    
    private func setupSearchView() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
    }
    
    
    

    
    func filterContentForSearchText(_ searchText: String) {
        filteredBeers = beers.filter { (beer: BeerViewModel) -> Bool in
            if isSearchBarEmpty {
                return false
            } else {
                return beer.name.lowercased().contains(searchText.lowercased())
            }
        }
        self.myTableView.reloadData()
    }
    
    func handleKeyboard(notification: Notification) {
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            view.layoutIfNeeded()
            return
        }
        
        guard
            let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }
        
        _ = keyboardFrame.cgRectValue.size.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }

}

extension SearchViewController: SearchViewPresenterInterface {

    func reloadData() {
        self.beers = self.presenter!.arrayBeerViewModel
        self.myTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredBeers.count
        }
        return self.presenter?.getNumberOfRowInsections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: SearchViewCell.defaultReuseIdentifier, for: indexPath) as! SearchViewCell
        if var data = self.presenter?.setObjectInTableView(indexPath: indexPath.row) {
            if isFiltering {
                data = filteredBeers[indexPath.row]
            } else {
                data = beers[indexPath.row]
            }
            cell.setup(data: data)
        }
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!)
  }
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
