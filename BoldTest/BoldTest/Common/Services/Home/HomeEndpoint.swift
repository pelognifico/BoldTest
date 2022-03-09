//
//  HomeEndpoint.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Alamofire

enum HomeEndpoint {
    case getLocationQuery(query: String)
}

extension HomeEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getLocationQuery:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getLocationQuery(let query):
            return "location/search/?query=\(query)"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getLocationQuery:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getLocationQuery:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
