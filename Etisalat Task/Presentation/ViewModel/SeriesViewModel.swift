//
//  SeriesViewModel.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import Foundation
class SeriesViewModel{
    
    var searchedSeries: [Series]?
    var seriesArr: [Series]?
    
    var bindingSeriesToController: (() -> ()) = {}
    var retreivedSeries: [Series] = [] {
        didSet {
            bindingSeriesToController()
        }
    }
    private var seriesNetworkObj: SeriesServiceClass = SeriesServiceClass()
    
    func getSeries() {
        seriesNetworkObj.fetchSeries { seriesModel in
            self.retreivedSeries = seriesModel?.data.results ?? []
        }
    }
    
}

