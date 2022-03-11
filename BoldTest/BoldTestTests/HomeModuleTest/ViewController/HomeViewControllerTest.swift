//
//  HomeViewControllerTest.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
import Foundation
@testable import BoldTest

class HomeViewControllerTest: XCTestCase {
    var sut: HomeViewController!
    var viewControllerMock: HomeDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = HomeDisplayLogicMock()
        sut = HomeViewController()
    }
    
    func testGetLocationsQuery() {
        //Given
        let responseMock = [SearchLocationModel.GetSearchLocationQuery.Response(title: "ABC", location_type: "ABC", woeid: 123, latt_long: "ABC")]
        
        let viewModel = SearchLocationModel.GetSearchLocationQuery.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayLocationQuery(viewModel: viewModel, on: queue)
        
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
