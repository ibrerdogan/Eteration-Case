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
    var updateView: ()->() {get set}
}

protocol CartViewModelEventSource: CartViewModelDataSource {
    func getCartProducts()
    func configureObservables()
}

protocol CartViewModelProtocol: CartViewModelEventSource { }

final class CartViewModel: CartViewModelProtocol {
    var updateView: () -> () = { }
    var cartProducts = [ETProductModel]()
    
    var coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        getCartProducts()
        configureObservables()
    }
    
    func getCartProducts(){
        cartProducts = coreDataManager.fetchAllProducts().filter({$0.cartQuantity > 0})
        updateView()
    }
    
    func updateCartWithModel(with model: ETProductModel){
        coreDataManager.updateProduct(productModel: ETProduct(from: model))
        getCartProducts()
    }
    
    func configureObservables() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .cartUpdated, object: nil)
    }
    
    @objc private func handleNotification(_ notification: Notification) {
        getCartProducts()
    }
    
    deinit {
           NotificationCenter.default.removeObserver(self)
       }
    
}
