//
//  ComicsViewCellDrawer.swift
//  PruebaMarvel
//
//  Created by Andres Felipe Ocampo Eljaiek.
//

import Foundation
import UIKit

class BeerViewCellDrawer {

    static func cell(model: BeerViewModel, tableView: UITableView, presenter: Any?) -> UITableViewCell {
        guard let cell = BaseTableViewCell<Any>.createBaseCell(tableView: tableView, cell: BeerTableViewCell.self, cellName: BeerTableViewCell.defaultReuseIdentifier, model: model) else {
            return UITableViewCell()
        }
        return cell
    }
    
}
