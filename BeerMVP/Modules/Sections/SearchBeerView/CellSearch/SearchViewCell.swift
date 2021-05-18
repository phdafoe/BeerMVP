//
//  SearchViewCell.swift
//  BeerMVP
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/5/21.
//

import UIKit

class SearchViewCell: UITableViewCell, ReuseIdentifierProtocol {
    
    
    @IBOutlet weak var myNameBeerLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(data: BeerViewModel) {
        self.myNameBeerLBL.text = data.name
    }
    
}
