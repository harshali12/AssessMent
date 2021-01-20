//
//  NetworkServices.swift
//  Assessment
//
//  Created by APPLE on 14/01/21.
//

import Foundation
import UIKit
import Alamofire

typealias anyDict = [String : Any]
typealias stringDict = HTTPHeaders


enum NetworkEnvironment: String {
    case development
}

enum NetworkAPI {
    
    fileprivate var networkEnvironment: NetworkEnvironment {
        return .development
    }
    
    case sifeedsApi
  
}

extension NetworkAPI {
    private var baseURL: String {
        switch networkEnvironment {
        case .development:
            // Change
            return "https://cricket.yahoo.net/"
            
        }
    }
    
    var path: String {
        var servicePath = ""
        switch self {
        case .sifeedsApi:
            servicePath = "sifeeds/cricket/live/json/sapk01222019186652.json"
        }
        
        return baseURL + servicePath
    }
    
    var headers: stringDict? {
        
        switch self {
        case .sifeedsApi:
            return ["Accept": "application/json"]
      
        }
    }
    
    var parameters: anyDict? {
        switch self {
        case .sifeedsApi :
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .sifeedsApi :
            return .get
        }
    }
    
    var encoding: JSONEncoding {
        return JSONEncoding.default
    }
}
