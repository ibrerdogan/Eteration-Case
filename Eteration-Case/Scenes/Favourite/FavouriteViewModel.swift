//
//  FavouriteViewModel.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import Foundation
import UIKit
protocol FavouriteViewModelDataSource {
    var coreDataManager: CoreDataManager {get set}
    var favouriteProductList: [ETProduct] {get set}
    var updateView: ()->() {get set}
}

protocol FavouriteViewModelEventSource: FavouriteViewModelDataSource {

}

protocol FavouriteViewModelProtocol: FavouriteViewModelEventSource { }

final class FavouriteViewModel: FavouriteViewModelProtocol {
    var updateView: () -> () = { }
    var favouriteProductList = [ETProduct]()
    var coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        getFavouriteItems()
        configureObservables()
    }
    
    func getFavouriteItems(){
        favouriteProductList.removeAll()
        coreDataManager.fetchAllProducts().filter({$0.isFavourite}).forEach { productModel in
            let product = ETProduct(from: productModel)
            favouriteProductList.append(product)
        }
        updateView()
    }
    func addFavItem(model: ETProduct){
        coreDataManager.updateProduct(productModel: model)
        getFavouriteItems()
        NotificationCenter.default.post(name: .favouritesUpdated, object: nil)
    }
    
    func addCardItem(model: ETProduct){
        var changedModel = model
        changedModel.productQuantity = (changedModel.productQuantity ?? 0) + 1
        coreDataManager.updateProduct(productModel: changedModel)
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
    
    func configureObservables() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .favouritesUpdated, object: nil)
    }
    
    @objc private func handleNotification(_ notification: Notification) {
        getFavouriteItems()
    }
    
    deinit {
           NotificationCenter.default.removeObserver(self)
       }
}
