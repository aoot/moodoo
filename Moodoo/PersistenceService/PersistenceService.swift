//
//  PersistenceService.swift
//  Moodoo
//
//  Created by Michael Moscoso on 3/28/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import Foundation
import CoreData
import FirebaseAuth

// Used to store user data locally on the target device
class PersistenceService {
    
    private init() {
        // Hard coded account for testing
        /*saveUser(username: "anthonyylee@utexas.edu",
         password: "anthony",
         email: "anthonyylee@utexas.edu",
         moodCount: 0)*/
    }
    
    static let shared = PersistenceService()  // Singleton instance, class level varaible
    private var users: [NSManagedObject] = [NSManagedObject]()
    private var moods: [NSManagedObject] = [NSManagedObject]()
    private var currentUser: AppUser?         // private - Restricts the use to enclosing declaration
    
    func setCurrentUser(username: String) {
        currentUser = getUser(name: username)
        refreshData()
    }
    
    func refreshData() {
        fetchUsers()
        fetchMoods()
        setMoodCount()
        saveContext()
        setMoodCount()
    }
    
    // MARK: - Core Data stack
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Moodoo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


// User DM Management
extension PersistenceService {
    
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
    
    func saveUser(username:String, password:String, email:String, moodCount:Int) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName:"User", in:managedContext)
        let user = NSManagedObject(entity: entity!, insertInto:managedContext)
        
        user.setValue(username, forKey:"username")
        user.setValue(password, forKey:"password")
        user.setValue(email, forKey:"email")
        user.setValue(moodCount, forKey:"moodCount")
        
        do {
            try managedContext.save()
            users.append(user)
            setCurrentUser(username: username) // Sets current user when saving to core data
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func getUser(name: String) -> AppUser {
        for user in users {
            let un = user.value(forKey:"username") as! String
            if un == name {
                let pw = user.value(forKey:"password") as! String
                let em = user.value(forKey:"email") as! String
                let mc = user.value(forKey:"moodCount") as! Int
                
                return AppUser(username: un, password: pw, email:em, moodCount:mc)
            }
        }
        
        return AppUser(username:"<bad>", password:"<bad>", email:"<bad>", moodCount: 0)
    }
    
    func getUsername() -> String {
        return currentUser!.username
    }
    
}


// Mood DM Management
extension PersistenceService {
    
    func fetchMoods() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Mood")
        fetchRequest.predicate = NSPredicate(format: "user == %@", currentUser!.username)
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        guard let results = fetchedResults else { return }
        moods = results
    }
    
    func saveMood(angry:String, happy:String, excited:String, sad: String, sleep: String, reasons: String, date: String) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName:"Mood", in:managedContext)
        let mood = NSManagedObject(entity: entity!, insertInto:managedContext)
        
        mood.setValue(angry, forKey: "angry")
        mood.setValue(happy, forKey: "happy")
        mood.setValue(sad, forKey: "sad")
        mood.setValue(excited, forKey: "excited")
        mood.setValue(sleep, forKey: "sleep")
        mood.setValue(reasons, forKey: "reasons")
        mood.setValue(date, forKey: "date")
        mood.setValue(currentUser!.username, forKey:"user")
        
        do {
            try managedContext.save()
            moods.append(mood)
            refreshData()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func getMood(date: Date) -> UserMood {
        
        for mood in moods {
            
            let d = mood.value(forKey: "date") as! String
            if d == DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .none) {
                let a = mood.value(forKey: "angry") as! String
                let h = mood.value(forKey: "happy") as! String
                let e = mood.value(forKey: "excited") as! String
                let sa = mood.value(forKey: "sad") as! String
                let sl = mood.value(forKey: "sleep") as! String
                let r = mood.value(forKey: "reasons") as! String
                
                return UserMood(angry: a, happy: h, excited: e, sad: sa, sleep: sl, reasons: r, date: d, user: currentUser!)
            }
        }
        
        return UserMood(angry: "<bad>", happy: "<bad>", excited: "<bad>", sad: "<bad>", sleep: "<bad>", reasons: "<bad>", date: "01/01/2001", user: currentUser!)
    }
    
    func checkMoodForDay(date: Date) -> Bool {
        return getMood(date: date).angry != "<bad>"
    }
    
    func deleteAllMoods() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Mood")
        fetchRequest.predicate = NSPredicate(format: "user == %@", currentUser!.username)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            
            try managedContext.save()
            refreshData()
        } catch let error as NSError {
            print("Delete all data in Mood error : \(error) \(error.userInfo)")
        }
    }
    
    func setMoodCount() {
        for user in users {
            if user.value(forKey: "username") as! String == currentUser!.username {
                user.setValue(moods.count, forKey: "moodCount")
                currentUser?.moodCount = moods.count
            }
        }
    }
    
    func getMoodCount() -> Int {
        return moods.count
    }
    
}
