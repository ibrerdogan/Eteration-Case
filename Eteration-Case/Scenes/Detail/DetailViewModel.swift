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
    var coreDataManager: CoreDataManager {get set}
}

protocol DetailViewModelEventSource: DetailViewModelDataSource {
    func addCardItem()
}

protocol DetailViewModelProtocol: DetailViewModelEventSource { }

final class DetailViewModel: DetailViewModelProtocol {
    var coreDataManager: CoreDataManager
    var selectedProduct: ETProduct
    
    init(selectedProduct: ETProduct, coredataManager: CoreDataManager) {
        self.selectedProduct = selectedProduct
        self.coreDataManager = coredataManager
    }

    func addCardItem() {
        var changedModel = selectedProduct
        changedModel.productQuantity = (changedModel.productQuantity ?? 0) + 1
        coreDataManager.updateProduct(productModel: changedModel)
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
}
