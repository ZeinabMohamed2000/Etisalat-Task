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
        savedSeries.setValue(series.title, forKey: "title")
        savedSeries.setValue(series.startYear, forKey: "year")
        savedSeries.setValue(series.rating, forKey: "rating")
        
        do{
            try managedContext.save()
        }catch let error {
            print (error)
        }
    }
    func fetchFromCoreData() -> [NSManagedObject]{
        var seriesFromCoreData : [NSManagedObject]!
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreDataSeries")
        
        do{
            seriesFromCoreData = try self.managedContext.fetch(fetchRequest)
           
        } catch let error {
            print (error)
        }
        
        return seriesFromCoreData
    }
    
}
