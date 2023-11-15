//
//  SeriesService.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import Foundation

protocol SeriesService{
    func fetchSeries(offset: Int, limit: Int, complition: @escaping (Result<SeriesModel, SError>)-> Void)
}

class SeriesServiceClass: SeriesService {
    func fetchSeries(offset: Int, limit: Int, complition: @escaping (Result<SeriesModel, SError>) -> Void) {
        let baseUrl = "https://gateway.marvel.com/v1/public/"
        let key = "18b49ecc4d6955811067a2204034ea35"
        let hash = "134e000a80dbeccfc25a4a39f0cb1f12"
        
        let endpoint = "\(baseUrl)series?ts=1&apikey=\(key)&hash=\(hash)&offset=\(offset)&limit=\(limit)"
        //let url = URL(string: "https://gateway.marvel.com/v1/public/series?ts=1&apikey=18b49ecc4d6955811067a2204034ea35&hash=134e000a80dbeccfc25a4a39f0cb1f12")
        
        guard let url = URL(string: endpoint) else {
            complition(.failure(.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let urlData = data else {
                complition(.failure(.invalidResponse))
                return}
            do{
                let series = try JSONDecoder().decode(SeriesModel.self, from: urlData)
                complition(.success(series))
                print(series.code)
            }
            catch{
                complition(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
}

enum SError: String, Error {
    case invalidUrl = "This url isn't invaild"
    case unableToComplete = "Unable to complete your request.Please check your internet connection"
    case invalidResponse = "Invalid response form the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
}
