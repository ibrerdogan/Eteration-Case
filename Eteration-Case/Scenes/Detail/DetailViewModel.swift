//
//  DetailViewModel.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import Foundation
import Foundation
protocol DetailViewModelDataSource {
    var selectedProduct: ETProduct {get set}
}

protocol DetailViewModelEventSource: DetailViewModelDataSource {
    
}

protocol DetailViewModelProtocol: DetailViewModelEventSource { }

final class DetailViewModel: DetailViewModelProtocol {
    var selectedProduct: ETProduct
    
    init(selectedProduct: ETProduct) {
        self.selectedProduct = selectedProduct
    }
    
}
