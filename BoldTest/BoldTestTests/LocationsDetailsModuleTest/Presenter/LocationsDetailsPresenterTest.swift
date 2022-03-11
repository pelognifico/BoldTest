//
//  LocationsDetailsPresenterTest.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
import Foundation
@testable import BoldTest

class LocationsDetailsPresenterTest: XCTestCase {
    var sut: LocationsDetailsPresenter!
    var viewControllerMock: LocationsDetailsDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = LocationsDetailsDisplayLogicMock()
        sut = LocationsDetailsPresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentLocationsDetails() {
        //Given
        let responseMock = LocationsDetailsModel.GetLocationsDetails.Response(consolidatedWeather: .none, woeid: 123, title: "ABC", sources: .none)
        
        let viewModel = LocationsDetailsModel.GetLocationsDetails.ViewModel(consolidatedWeather: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayLocationsDetails(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentLocationsDetails(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testPresentLocationsQueryFailure() {
        //Given
        let error: HomeError = .request
        let responseMock = SearchLocationModel.Error.Response(error: error)
        let viewModel = SearchLocationModel.Error.ViewModel(error: error)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayError(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentError(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
}
