//
//  ComicsTableViewCell.swift
//  PruebaMarvel
//
//  Created by Andres Felipe Ocampo Eljaiek
//

import UIKit
import Kingfisher

class BeerTableViewCell: BaseTableViewCell<BeerViewModel>, ReuseIdentifierProtocol {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myNameLBL: UILabel!
    @IBOutlet weak var myTagLiner: UILabel!
    var model: BeerViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override func configure(cellModel: BeerViewModel) {
        super.configure(cellModel: cellModel)
        self.model = cellModel
        self.myNameLBL.text = cellModel.name
        self.myTagLiner.text = cellModel.tagline
        DispatchQueue.main.async {
            self.myImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: cellModel.imageurl)!),
                                         placeholder: UIImage(named: "img-loading"),
                                         options: [
                                            .scaleFactor(UIScreen.main.scale),
                                            .transition(.fade(1)),
                                            .cacheOriginalImage
                                         ],
                                         completionHandler: nil)
        }
    }
}
