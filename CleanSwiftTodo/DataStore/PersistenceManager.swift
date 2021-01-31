//
//  PersistenceManager.swift
//  CleanSwiftTodo
//
//  Created by Panda on 2021/01/30.
//

import CoreData

protocol PersistenceManagerType {
    
}

class PersistenceManager {
    static var shared: PersistenceManager = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CleanSwiftTodo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
        
    }
    
    @discardableResult
    func delete(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    func insertPerson(todo: Todo) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Todo", in: self.context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
          managedObject.setValue(todo.title, forKey: "title")
          managedObject.setValue(todo.date, forKey: "date")
          managedObject.setValue(todo.contents, forKey: "contents")
            do {
                try self.context.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    // MARK: - Usage
    // let request: NSFetchRequest<Person> = Person.fetchRequest()
    // PersistenceManager.shared.deleteAll(request: request)
    // let arr = PersistenceManager.shared.fetch(request: request)
    // if arr.isEmpty { print("clean") }
    @discardableResult
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
