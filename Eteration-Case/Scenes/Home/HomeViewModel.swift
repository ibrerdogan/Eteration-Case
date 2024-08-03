//
//  HomeViewModel.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation
import UIKit
protocol HomeViewModelDataSource {
    var networkService: NetworkService {get set}
    var productItemList: [ETProduct] {get set}
    var staticProductItemList: [ETProduct] {get set}
    var updateView: ()->() {get set}
}

protocol HomeViewModelEventSource: HomeViewModelDataSource {
    func fethItems() async
}

protocol HomeViewModelProtocol: HomeViewModelEventSource { }

final class HomeViewModel: HomeViewModelProtocol {
    var updateView: () -> () = { }
    var productItemList: [ETProduct] = []
    var staticProductItemList: [ETProduct] = []
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        Task{
            await fethItems()
        }
    }
    
    func fethItems() async{
        do {
            if let products : [ETProduct] = try await networkService.request(endpoint: .getProducts){
                productItemList = products
                staticProductItemList = products
                updateView()
            }
        }
        catch{
            print("error")
        }
    }
    
    func searchProduct(with text: String)
    {
        if !text.isEmpty{
            let newArray = staticProductItemList.filter({$0.name.contains(text)})
            productItemList = newArray
            updateView()
        }else {
            productItemList = staticProductItemList
            updateView()
        }
    }

}
