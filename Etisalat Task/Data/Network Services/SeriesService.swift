//
//  SeriesService.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import Foundation

protocol SeriesService{
    func fetchSeries(complition: @escaping (SeriesModel?)-> Void)
}

class SeriesServiceClass: SeriesService {
    func fetchSeries(complition: @escaping (SeriesModel?) -> Void) {
        let baseUrl = "https://gateway.marvel.com/v1/public/"
        let key = "18b49ecc4d6955811067a2204034ea35"
        let hash = "134e000a80dbeccfc25a4a39f0cb1f12"
        
        let url = "\(baseUrl)series?ts=1&apikey=\(key)&hash=\(hash)"
        //let url = URL(string: "https://gateway.marvel.com/v1/public/series?ts=1&apikey=18b49ecc4d6955811067a2204034ea35&hash=134e000a80dbeccfc25a4a39f0cb1f12")
        
        guard let url = URL(string: url) else {
            complition(nil)
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let urlData = data else {
                complition(nil)
                return}
            do{
                let series = try JSONDecoder().decode(SeriesModel.self, from: urlData)
                complition(series)
                print(series.code)
            }
            catch{
                complition(nil)
            }
        }
        task.resume()
    }
    
    
}
