//
//  ETProductModel+CoreDataProperties.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//
//

import Foundation
import CoreData


extension ETProductModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ETProductModel> {
        return NSFetchRequest<ETProductModel>(entityName: "ETProductModel")
    }

    @NSManaged public var id: String?
    @NSManaged public var brand: String?
    @NSManaged public var model: String?
    @NSManaged public var descriptionString: String?
    @NSManaged public var price: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var cartQuantity: Int16

}

extension ETProductModel : Identifiable {

}
