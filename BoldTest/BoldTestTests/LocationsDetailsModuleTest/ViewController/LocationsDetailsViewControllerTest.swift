//
//  LocationsDetailsViewControllerTest.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
import Foundation
@testable import BoldTest

class LocationsDetailsViewControllerTest: XCTestCase {
    var sut: LocationsDetailsViewController!
    var viewControllerMock: LocationsDetailsDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = LocationsDetailsDisplayLogicMock()
        sut = LocationsDetailsViewController()
    }
    
    func testGetLocationsDetails() {
        //Given
        let responseMock = LocationsDetailsModel.GetLocationsDetails.Response(consolidatedWeather: .none, woeid: 123, title: "ABC", sources: .none)
        
        let viewModel = LocationsDetailsModel.GetLocationsDetails.ViewModel(consolidatedWeather: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayLocationsDetails(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.loadInitialData()
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testFailure() {
        //Given
        let error: HomeError = .request
        let viewModel = SearchLocationModel.Error.ViewModel(error: error)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayError(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.displayError(viewModel: viewModel, on: queue)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
}
