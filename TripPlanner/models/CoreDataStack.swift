//
//  CoreDataStack.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/9/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataStack: NSObject {
    let persistentContainer: NSPersistentContainer = {
        // creates the NSPersistentContainer object
        // must be given the name of the Core Data model file “LoanedItems”
        let container = NSPersistentContainer(name: "TripItem")
        
        // load the saved database if it exists, creates it if it does not, and returns an error under failure conditions
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    func saveContext() {
        let viewContext = persistentContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func fetchPersistedData(completion: @escaping (FetchItemsResult) -> Void) {
        
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        let viewContext = persistentContainer.viewContext
        
        do {
            let allItems = try viewContext.fetch(fetchRequest)
            completion(.success(allItems))
        } catch {
            completion(.failure(error))
        }
    }
}
enum FetchItemsResult {
    case success([Trip])
    case failure(Error)
}
