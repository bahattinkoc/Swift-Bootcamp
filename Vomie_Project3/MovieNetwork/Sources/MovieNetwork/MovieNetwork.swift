//
//  Created by Bahattin Koç on 23.04.2022.
//

import Alamofire
import Foundation

final public class MovieNetworkManager {

    public static let shared: MovieNetworkManager = {
        let instance = MovieNetworkManager()
        return instance
    }()
    
    public func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    public func request<T: Decodable>(_ request: URLRequestConvertible, completion: @escaping (Result<T, Error>) -> ()) {
        AF.request(request).responseData { response in
            if case .success(let data) = response.result {
                guard let response = try? JSONDecoder().decode(T.self, from: data) else {
                    print("JSON Decode Error")
                    return
                }
                completion(.success(response))
            } else if case .failure(let error) = response.result {
                print("JSON Decode Failure: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
