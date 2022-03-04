//
//  CampaignRequest.swift
//  week8
//
//  Created by Bahattin Koç on 26.02.2022.
//

import Foundation

enum CampaignError: Error{
    case noDataAvaible
    case canNotProcessData
}

struct CampaignRequest{
    let resourceURL: URL
    
    init(){
        let resourceString = "http://www.bucayapimarket.com/json.php"
        // let resourceString = "https://jsonplaceholder.typicode.com/users"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("Error")
        }
        self.resourceURL = resourceURL
    }
    
    func getCampaign(completion: @escaping(Result<[Campaign], CampaignError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvaible))
                return
            }
            
            do {
                let campaigns = try JSONDecoder().decode([Campaign].self, from: jsonData)
                completion(.success(campaigns))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
