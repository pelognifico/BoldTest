//
//  LocationsDetailsPresentationLogicMock.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import Foundation
@testable import BoldTest

final class LocationsDetailsPresentationLogicMock: LocationsDetailsPresentationLogic {
    
    var responseLocationsDetails: LocationsDetailsModel.GetLocationsDetails.Response?
    var isFunctionWasCalled = false
    
    func presentLocationsDetails(response: LocationsDetailsModel.GetLocationsDetails.Response) {
        if responseLocationsDetails != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: SearchLocationModel.Error.Response) {
        isFunctionWasCalled = true
    }
}
