//
//  NetworkService.swift
//  
//
//  Created by Bahattin Koç on 6.04.2022.
//

import Alamofire
import Foundation

// MARK: - Protocols
public protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(urlString: String, completion: @escaping(Result<[T], Error>) -> ())
}

// MARK: - Class
final public class NetworkService: NetworkServiceProtocol {
    public init() {}
    
    public func fetchData<T: Decodable>(urlString: String, completion: @escaping(Result<[T], Error>) -> ()) {
        guard !urlString.isEmpty else { return }
        AF.request(urlString).responseData { response in
            if case .success(let data) = response.result {
                guard let response = try? JSONDecoder().decode([T].self, from: data) else {
                    print("JSON Decode Error")
                    return
                }
                completion(.success(response))
            } else if case .failure(let error) = response.result {
                print("JSON Decode Failure: \(error.localizedDescription)")
            }
        }
    }
}
