//
//  LocationsDetailsDisplayLogicMock.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import Foundation
@testable import BoldTest

final class LocationsDetailsDisplayLogicMock: LocationsDetailsDisplayLogic {
    
    var viewModelDisplayLocationsDetails: LocationsDetailsModel.GetLocationsDetails.ViewModel?
    var isFunctionWasCalled = false
    
    func displayLocationsDetails(viewModel: LocationsDetailsModel.GetLocationsDetails.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: SearchLocationModel.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}

