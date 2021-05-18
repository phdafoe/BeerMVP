//
//  CommonFactoryCells.swift
//  PruebaMarvel
//
//  Created by Andres Felipe Ocampo Eljaiek
//

import UIKit

class CommonFactoryCells: NSObject {

    class func view(for object: Any?, tableView: UITableView, presenter: Any? = nil) -> UIView {
        return self.cell(for: object, tableView: tableView, presenter: presenter).contentView
    }

    class func cell(for object: Any?, tableView: UITableView, presenter: Any? = nil) -> UITableViewCell {
        switch object {
        case let model as BeerViewModel:
            return BeerViewCellDrawer.cell(model: model, tableView: tableView, presenter: presenter)
        default:
            return UITableViewCell()
        }
    }
}
