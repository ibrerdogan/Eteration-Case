//
//  CartViewModel.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation
protocol CartViewModelDataSource {
    var coreDataManager: CoreDataManager {get set}
    var cartProducts: [ETProductModel] {get set}
}

protocol CartViewModelEventSource: CartViewModelDataSource {
    func getCartProducts()
}

protocol CartViewModelProtocol: CartViewModelEventSource { }

final class CartViewModel: CartViewModelProtocol {
    
    var cartProducts = [ETProductModel]()
    
    var coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        getCartProducts()
    }
    
    func getCartProducts(){
        cartProducts = coreDataManager.fetchAllProducts().filter({$0.cartQuantity > 0})
    }
}
