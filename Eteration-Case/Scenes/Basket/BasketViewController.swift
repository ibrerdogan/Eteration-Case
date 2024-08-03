//
//  BasketViewController.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 2.08.2024.
//

import UIKit

class BasketViewController: UIViewController {
    var coreDataManager = CoreDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let data = coreDataManager.fetchAllProducts()
        data.forEach { item in
            print(item.brand)
        }
    }


}

