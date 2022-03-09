//
//  LocationsDetailsModel.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 9/3/22.
//

import Foundation

enum LocationsDetailsModel {
  
    // MARK: Use cases
    enum GetLocationsDetails {
        struct Request {
            let woeid : Int
        }
        struct Response: Codable {
            
            let results : LocationsDetails?
            
            enum CodingKeys: String, CodingKey {
                case results
            }
        }
        struct ViewModel {
            let dataLocationsDetails  : LocationsDetails?
        }
    }
}
