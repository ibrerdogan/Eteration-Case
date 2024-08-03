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
    var updateView: ()->() {get set}
}

protocol HomeViewModelEventSource: HomeViewModelDataSource {
    func fethItems() async
}

protocol HomeViewModelProtocol: HomeViewModelEventSource { }

final class HomeViewModel: HomeViewModelProtocol {
    var updateView: () -> () = { }
    var productItemList: [ETProduct] = []
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
                updateView()
            }
        }
        catch{
            print("error")
        }
    }

}
