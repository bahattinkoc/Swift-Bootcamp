//
//  Router.swift
//  Vomie
//
//  Created by Bahattin Koç on 26.04.2022.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let apiKey = "dc5ae13134361c8a261579c7e42a0938"
    
    case nowPlaying
    case upcoming
    case searchMovie(query: String?)
    case movie(id: Int?)
    case similarMovies(id: Int?)
    
    var baseUrl: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .nowPlaying, .upcoming, .searchMovie, .movie, .similarMovies:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var params: Parameters = [:]
        switch self {
        case .nowPlaying, .upcoming, .movie:
            return nil
        case .searchMovie(query: let query):
            if let query = query  {
                params["query"] = query
            }
        case .similarMovies(id: let id):
            if let id = id {
                params["id"] = id
            }
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .upcoming:
            return "movie/upcoming"
        case .searchMovie:
            return "search/movie"
        case .movie(id: let id):
            guard let id = id else { return "" }
            return "movie/\(id)"
        case .similarMovies(id: let id):
            guard let id = id else { return "" }
            return "movie/\(id)/similar"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        completeParameters["api_key"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        debugPrint("*****> MY URL: ", urlRequestPrint.url ?? "")
        
        return try encoding.encode(urlRequest, with: completeParameters)
    }
}
