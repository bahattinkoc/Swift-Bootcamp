//
//  Router.swift
//  ViperNews
//
//  Created by Bahattin Koç on 22.04.2022.
//

import Alamofire
import Foundation

enum Router: URLRequestConvertible {
    static let apiKey = "9a571a7f23474b54ba8fc41c87e43979"
    
    case sources
    case topHeadlines(source: String?)
    case everything(source: String?, page: Int?, query: String?)
    
    var baseUrl: URL {
        return URL(string: "https://newsapi.org/v2")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .sources, .everything, .topHeadlines:
            return .get
        }
    }
    
    var parameters: [String:Any]? {
        var params: Parameters = [:]
        switch self {
        case .sources:
            return nil
        case .topHeadlines(source: let source):
            if let source = source {
                params["sources"] = source
            }
        case .everything(source: let source, page: let page, query: let query):
            if let source = source {
                params["sources"] = source
            }
            if let page = page {
                params["page"] = page
            }
            if let query = query {
                params["query"] = query
            }
        }
        
        return params
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .sources:
            return "sources"
        case .topHeadlines:
            return "top-headlines"
        case .everything:
            return "everything"
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
        
        completeParameters["apiKey"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        debugPrint("***> MY URL: ", urlRequestPrint)
        
        return try encoding.encode(urlRequest, with: completeParameters)
    }
}
