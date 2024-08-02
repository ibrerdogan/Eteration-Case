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
}
