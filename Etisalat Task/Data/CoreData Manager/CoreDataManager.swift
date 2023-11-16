//
//  CoreDataManager.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext : NSManagedObjectContext!
    let entity : NSEntityDescription!
    
    private static var sharedInstance : CoreDataManager?
    
    public static func getInstance()->CoreDataManager{
        
        if sharedInstance == nil {
            sharedInstance = CoreDataManager()
        }
        
        return sharedInstance!
    }
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "CoreDataSeries", in: self.managedContext)
    }
    
    func saveToCoreData(series: Series){
        let savedSeries = NSManagedObject(entity: entity!, insertInto: managedContext)
        savedSeries.setValue(series.id, forKey: "id")
        savedSeries.setValue(series.description, forKey: "desc")
        savedSeries.setValue(series.type, forKey: "type")
        do{
            try managedContext.save()
        }catch let error {
            print (error)
        }
    }
    func fetchFromCoreData(seriesId: Int) -> [NSManagedObject]{
        var seriesFromCoreData : [NSManagedObject]!
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreDataSeries")
        
        do{
            let predicate = NSPredicate(format: "id == %@", seriesId)
            fetchRequest.predicate = predicate
            seriesFromCoreData = try self.managedContext.fetch(fetchRequest)
           
        } catch let error {
            print (error)
        }
        
        return seriesFromCoreData
    }
    
}
