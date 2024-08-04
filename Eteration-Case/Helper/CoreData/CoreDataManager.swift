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
    func addProduct(productModel: ETProduct) {
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
        product.isFavourite = productModel.isFav ?? false
        product.cartQuantity = productModel.productQuantity ?? 0
        
        saveContext()
    }
    
    // Update item
    func updateProduct(productModel: ETProduct) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ETProductModel> = ETProductModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", productModel.id)
        
        do {
            let products = try context.fetch(fetchRequest)
            if let product = products.first {
                if let isFav = productModel.isFav {
                    product.isFavourite = isFav
                    if !product.isFavourite && product.cartQuantity <= 0{
                        context.delete(product)
                    }
                }
                //TODO: check add again make zero
                if let increaseQuantity = productModel.productQuantity{
                    let quantity = product.cartQuantity
                    product.cartQuantity = increaseQuantity
                    if product.cartQuantity <= 0 && !product.isFavourite{
                        context.delete(product)
                    }
                }
                saveContext()
            }
            else{
                addProduct(productModel: productModel)
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
