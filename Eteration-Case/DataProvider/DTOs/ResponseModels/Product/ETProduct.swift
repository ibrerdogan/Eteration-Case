//
//  ETProduct.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation

struct ETProduct: Codable {
    let createdAt, name: String
    let image: String
    let price, description, model, brand: String
    let id: String
    var isFav: Bool?
    var productQuantity: Int16?
    
    
    init(from coreModel: ETProductModel){
        id = coreModel.id ?? ""
        createdAt = coreModel.createdAt ?? ""
        name = coreModel.name ?? ""
        image = coreModel.image ?? ""
        price = coreModel.price ?? ""
        description = coreModel.descriptionString ?? ""
        model = coreModel.model ?? ""
        brand = coreModel.brand ?? ""
        isFav = coreModel.isFavourite
        productQuantity = coreModel.cartQuantity
    }
    
    var priceValue: Double? {
        return Double(price)
    }
        
    var dateValue: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: createdAt)
    }
}
