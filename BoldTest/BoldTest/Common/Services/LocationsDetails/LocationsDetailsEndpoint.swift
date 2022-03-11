//
//  LocationsDetailsEndpoint.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 9/3/22.
//

import Alamofire

enum LocationsDetailsEndpoint {
    case getLocationsDetails(woeid: Int)
}

extension LocationsDetailsEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getLocationsDetails:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getLocationsDetails(let woeid):
            return "location/\(woeid)/"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getLocationsDetails:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getLocationsDetails:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
