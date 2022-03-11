//
//  LocationsDetailsAPI.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 9/3/22.
//

import Foundation

protocol LocationsDetailsServiceProtocol {
    func getLocationsDetails(request: LocationsDetailsModel.GetLocationsDetails.Request, completion: @escaping (Result<LocationsDetailsModel.GetLocationsDetails.Response, HomeError>) -> Void)
}

class LocationsDetailsAPI: LocationsDetailsServiceProtocol {
    
    func getLocationsDetails(request: LocationsDetailsModel.GetLocationsDetails.Request, completion: @escaping (Result<LocationsDetailsModel.GetLocationsDetails.Response, HomeError>) -> Void) {
        NetworkService.share.request(endpoint: LocationsDetailsEndpoint.getLocationsDetails(woeid: request.woeid)) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode(LocationsDetailsModel.GetLocationsDetails.Response.self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
