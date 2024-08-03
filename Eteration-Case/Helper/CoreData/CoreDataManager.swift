//
//  CoreDataManager.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Eteration_Case") // Use the name of your .xcdatamodeld file
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    // Save context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Add new item
    func addProduct(productModel: ETProduct,isFav: Bool, quantity: Int) {
        let context = persistentContainer.viewContext
        let product = ETProductModel(context: context)
        product.createdAt = productModel.createdAt
        product.name = productModel.name
        product.image = productModel.image
        product.price = productModel.price
        product.descriptionString = productModel.description
        product.model = productModel.model
        product.brand = productModel.brand
        product.id = productModel.id
        product.isFavourite = isFav
        product.cartQuantity = Int16(quantity)
        
        saveContext()
    }
    
    // Update item
    func updateProduct(id: String, isFav: Bool?, quantity: Int?) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ETProductModel> = ETProductModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let products = try context.fetch(fetchRequest)
            if let product = products.first {
                if let isFav = isFav {
                    product.isFavourite = isFav
                }
                if let quantity = quantity {
                    if quantity == 0 {
                        context.delete(product)
                    } else {
                        product.cartQuantity = Int16(quantity)
                    }
                }
                saveContext()
            }
        } catch {
            print("Failed to fetch product: \(error)")
        }
    }
    
    // Fetch all products
    func fetchAllProducts() -> [ETProductModel] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ETProductModel> = ETProductModel.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch products: \(error)")
            return []
        }
    }
}
