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
            
            let consolidatedWeather : [ConsolidatedWeather]?
            let woeid : Int?
            let title : String?
            let sources : [Sources]?
            
            enum CodingKeys: String, CodingKey {
                case consolidatedWeather = "consolidated_weather"
                case woeid
                case title
                case sources
            }
        }
        struct ViewModel {
            let consolidatedWeather  : LocationsDetailsModel.GetLocationsDetails.Response?
        }
    }
}
