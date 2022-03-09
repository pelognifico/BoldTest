//
//  HomeModel.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 8/3/22.
//

import Foundation

enum SearchLocationModel {
  
    // MARK: Use cases
    enum GetSearchLocationQuery {
        struct Request {
            let query : String
        }
        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
                
            }
            let title: String?
            let location_type: String?
            let woeid: Int?
            let latt_long: String?
            
            enum CodingKeys: String, CodingKey {
                case title
                case location_type
                case woeid
                case latt_long
            }
            
        }
        
        struct ViewModel {
            let data: [SearchLocationModel.GetSearchLocationQuery.Response]
        }
    }
    
    enum Error {
        struct Request {
        }
        struct Response {
            var error: HomeError
        }
        struct ViewModel {
            var error: HomeError
        }
    }
}
