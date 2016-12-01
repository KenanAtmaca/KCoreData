//
//  Created by K&
//  kenanatmaca.com
//  Copyright © 2016 Kenan Atmaca. All rights reserved.
//

// KCoreData v1.0

import UIKit
import CoreData

open class KCoreData: NSObject {
    
    var entityName:String!
    var fetchCount:Int?
    
    fileprivate var appDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate var context:NSManagedObjectContext!
    
    init(entityName:String,fetchCount:Int? = nil) {
        
        self.entityName = entityName
        self.fetchCount = fetchCount
        self.context = appDelegate.persistentContainer.viewContext
        
    }
    
    // INSERT
    
    func insert(data:[String:AnyObject],completion:((_ state:Bool) -> ())? = nil) {
        
        let newData = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        
        for (key,value) in data {
            newData.setValue(value, forKey: key)
        }
        
        do {
            
            try context.save()
            if completion != nil {completion!(true)}
            
        } catch {
            
            if completion != nil {completion!(false)}
            print(error)
        }
        
    }
    
    // FETCH
    
    func fetch() -> [NSManagedObject] {
        
        var data = [NSManagedObject]()
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetch.returnsObjectsAsFaults = false
        
        if fetchCount != nil {fetch.fetchLimit = fetchCount!}
        
        do {
            
            let results = try context.fetch(fetch)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    data.append(result)
                    
                }
            }
            
        } catch {
            print(error)
        }

        return data
    }
    
    // FETCH VALUES TO NAME
    
    func fetchValues(key:String) -> [AnyObject] {
        
        var item:[AnyObject] = []
        
        for items in fetch() {
            item.append(items.value(forKey: key) as AnyObject!)
        }
        
        return item
    }
    
    // FETCH WİDTH PREDİCATE
    
    func sortFetch(predicate:String?,ascending:Bool?,key:String?) -> [NSManagedObject] {
        
        var data = [NSManagedObject]()
    
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetch.returnsObjectsAsFaults = false
        
        if fetchCount != nil {fetch.fetchLimit = fetchCount!}
        
        if predicate != nil {
             let predicate = NSPredicate(format: predicate!)
             fetch.predicate = predicate
        }
        
        if key != nil && ascending != nil {
              let desc = NSSortDescriptor(key: key!, ascending: ascending!)
             fetch.sortDescriptors = [desc]
        }
        
        do {
            
            let results = try context.fetch(fetch)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    data.append(result)
                    
                }
            }
            
        } catch {
            print(error)
        }
        
        
        return data
  
    }
    
    // UPDATE
    
    func update(data:NSManagedObject,value:AnyObject,key:String,completion:((_ state:Bool) -> ())? = nil) {
    
        data.setValue(value, forKey: key)
        
        do {
            
            try context.save()
            if completion != nil {completion!(true)}
   
        } catch {
            
            print(error)
            if completion != nil {completion!(false)}
            
        }
        
    }
    
    // UPDATE WİTH PREDİCATE 
    
    func update(predicate:String,value:AnyObject,key:String,completion:((_ state:Bool) -> ())? = nil) {
        
        let datas:[NSManagedObject] = sortFetch(predicate: predicate, ascending: nil, key: nil)
        
        if !datas.isEmpty {
            for i in 0..<datas.count {
                datas[i].setValue(value, forKey: key)
            }
        }
        
        do {
            
            try context.save()
            if completion != nil {completion!(true)}
            
        } catch {
            
            print(error)
            if completion != nil {completion!(false)}
            
        }
        
    }
    
    // DELETE
    
    func delete(data:NSManagedObject,completion:((_ state:Bool) -> ())? = nil) {
        
        context.delete(data)
        
        do {
            
            try context.save()
           if completion != nil {completion!(true)}
            
        } catch {
            
            print(error)
            if completion != nil {completion!(false)}
        }
        
    }
    
    // DELETE MORE İTEMS
    
    func delete(datas:[NSManagedObject],completion:((_ state:Bool) -> ())? = nil) {
        
        if !datas.isEmpty {
            for i in 0..<datas.count {
                context.delete(datas[i])
            }
        }
        
        do {
            
            try context.save()
            if completion != nil {completion!(true)}
            
        } catch {
            
            print(error)
            if completion != nil {completion!(false)}
        }
        
    }
    
    // DELETE WİTH PREDİCATE
    
    func delete(predicate:String,completion:((_ state:Bool) -> ())? = nil) {
        
        let datas:[NSManagedObject] = sortFetch(predicate: predicate, ascending: nil, key: nil)
        
        if !datas.isEmpty {
            for i in 0..<datas.count {
                context.delete(datas[i])
            }
        }
        
        do {
            
            try context.save()
            if completion != nil {completion!(true)}
            
        } catch {
            
            print(error)
            if completion != nil {completion!(false)}
        }
        
    }
    

}//
