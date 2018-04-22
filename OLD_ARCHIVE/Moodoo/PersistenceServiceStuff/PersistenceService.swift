//
//  PersistenceService.swift
//  Moodoo
//
//  Created by Michael Moscoso on 3/28/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {
    
    private init() {}
    
    static let shared = PersistenceService()
    
    private var users: [NSManagedObject]!
    
    // MARK: - Core Data stack
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Moodoo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchUsers() {
        
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        guard let results = fetchedResults else { return }
        users = results
    }
    
    func saveUser(username:String, password:String, email:String) {
        
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName:"User", in:managedContext)
        let user = NSManagedObject(entity: entity!, insertInto:managedContext)
        
        user.setValue(username, forKey:"username")
        user.setValue(password, forKey:"password")
        user.setValue(email, forKey:"email")
        
        do {
            try managedContext.save()
            users.append(user)
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func userCount() -> Int {
        return users.count
    }
    
    func getUser(index:Int) -> AppUser {
        if index < users.count {
            let user = users[index]
            let un = user.value(forKey:"username") as! String
            let pw = user.value(forKey:"password") as! String
            let em = user.value(forKey:"email") as! String
            return AppUser(username: un, password: pw, email:em)
        }
        
        return AppUser(username:"<bad>", password:"<bad>", email:"<bad>")
    }
    
    func getUser(name:String) -> AppUser {
        for user in users {
            let un = user.value(forKey:"username") as! String
            if un == name {
                let pw = user.value(forKey:"password") as! String
                let em = user.value(forKey:"email") as! String
                return AppUser(username: un, password: pw, email:em)
            }
        }
        
        return AppUser(username:"<bad>", password:"<bad>", email:"<bad>")
    }

}
