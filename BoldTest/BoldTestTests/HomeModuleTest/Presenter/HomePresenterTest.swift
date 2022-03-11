//
//  HomePresenterTest.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
import Foundation
@testable import BoldTest

class HomePresenterTest: XCTestCase {
    var sut: HomePresenter!
    var viewControllerMock: HomeDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = HomeDisplayLogicMock()
        sut = HomePresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentLocationsQuerySuccess() {
        //Given
        let responseMock = [SearchLocationModel.GetSearchLocationQuery.Response(title: "ABC", location_type: "ABC", woeid: 123, latt_long: "ABC")]
        
        let viewModel = SearchLocationModel.GetSearchLocationQuery.ViewModel(data: [])
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayLocationQuery(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentLocationQuery(response: responseMock)
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
