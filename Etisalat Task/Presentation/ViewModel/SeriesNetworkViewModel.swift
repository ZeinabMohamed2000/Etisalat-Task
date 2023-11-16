//
//  SeriesNetworkViewModel.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import Foundation
import CoreData
class SeriesNetworkViewModel{
    
    var searchedSeries: [Series]?
    var seriesArr: [Series]?
    let userDefaults = UserDefaults.standard
    
    let itemsPerPage = 15
    var currentoffset = 0
    
    var bindingSeriesToController: (() -> ()) = {}
    var retreivedSeries: [Series] = [] {
        didSet {
            bindingSeriesToController()
        }
    }
    

    private var seriesNetworkObj: SeriesServiceClass = SeriesServiceClass()

    func getMoreSeries(offset: Int, limit: Int) {
        seriesNetworkObj.fetchSeries(offset: offset, limit: limit) { seriesModel in
            switch seriesModel {
            case .success(let series):
                self.retreivedSeries += series.data.results
            case .failure(_):
                print("error")
            }
            
        }
    }
}

class SeriesCoreDataViewModel{
    
    var seriesCoreDataArray: [NSManagedObject] = []
    var coreDataobj = CoreDataManager.getInstance()
    func saveSeriesToCoreData(series: Series){
        coreDataobj.saveToCoreData(series: series)
    }
    
    func fetchSeriesFromCoreData() -> [NSManagedObject]{
        return coreDataobj.fetchFromCoreData()
    }
    
}

