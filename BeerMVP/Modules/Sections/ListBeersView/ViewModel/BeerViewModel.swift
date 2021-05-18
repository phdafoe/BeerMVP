//
//  BeerViewModel.swift
//  BeerMVP
//
//  Created by Andres Felipe Ocampo Eljaiek on 17/5/21.
//

import Foundation

struct BeerViewModel {
    let imageurl: String
    let name: String
    let tagline: String

    init(viewModel: BeerServerModelElement) {
        self.imageurl = viewModel.imageurl
        self.name = viewModel.name
        self.tagline = viewModel.tagline
    }

}
