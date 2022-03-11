//
//  HomeInteractorTest.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
import Foundation
@testable import BoldTest

class HomeInteractorTest: XCTestCase {
    var sut: HomeInteractor!
    var locationsQueryPresenterMock: HomeWorkerMock!
    
    override func setUp() {
        locationsQueryPresenterMock = HomeWorkerMock()
        sut = HomeInteractor(worker: locationsQueryPresenterMock)
    }
    
    func testLocationsQuerySuccess() {
        //Given
        let requestData = SearchLocationModel.GetSearchLocationQuery.Request(query: "ABC")
        let responseMock = [SearchLocationModel.GetSearchLocationQuery.Response(title: "ABC", location_type: "ABC", woeid: 123, latt_long: "ABC")]
        
        locationsQueryPresenterMock.resultGetHome = .success(responseMock)
        locationsQueryPresenterMock.isFunctionWasCalled = false
        
        //When
        sut.getLocationQuery(request: requestData)
        let result = locationsQueryPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
    
    func testLocationsQueryFailure() {
        //Given
        let requestData = SearchLocationModel.GetSearchLocationQuery.Request(query: "ABC")
        let failure : HomeError = .request

        locationsQueryPresenterMock.resultGetHome = .failure(failure)
        locationsQueryPresenterMock.isFunctionWasCalled = false

        //When
        sut.getLocationQuery(request: requestData)
        let result = locationsQueryPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
}

