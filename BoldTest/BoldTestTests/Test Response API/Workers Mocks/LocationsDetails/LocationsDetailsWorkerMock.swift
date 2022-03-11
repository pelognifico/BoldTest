//
//  LocationsDetailsWorkerMock.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import Foundation
@testable import BoldTest

class LocationsDetailsWorkerMock : LocationsDetailsServiceProtocol {
    
    var resultGetLocationsDetails: (Result<LocationsDetailsModel.GetLocationsDetails.Response, HomeError>)?
    
    var isFunctionWasCalled = false
    
    func getLocationsDetails(request: LocationsDetailsModel.GetLocationsDetails.Request, completion: @escaping (Result<LocationsDetailsModel.GetLocationsDetails.Response, HomeError>) -> Void) {
        if let result = resultGetLocationsDetails {
            isFunctionWasCalled = true
            completion(result)
        }
    }
}
