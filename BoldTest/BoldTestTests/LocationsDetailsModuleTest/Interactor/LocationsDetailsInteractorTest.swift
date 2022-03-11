//
//  LocationsDetailsInteractorTest.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
import Foundation
@testable import BoldTest

class LocationsDetailsInteractorTest: XCTestCase {
    var sut: LocationsDetailsInteractor!
    var locationsDetailsPresenterMock: LocationsDetailsWorkerMock!
    
    override func setUp() {
        locationsDetailsPresenterMock = LocationsDetailsWorkerMock()
        sut = LocationsDetailsInteractor(worker: locationsDetailsPresenterMock)
    }
    
    func testLocationsDetailsSuccess() {
        //Given
        let requestData = LocationsDetailsModel.GetLocationsDetails.Request(woeid: 123)
        let responseMock = LocationsDetailsModel.GetLocationsDetails.Response(consolidatedWeather: .none, woeid: 123, title: "ABC", sources: .none)
        
        locationsDetailsPresenterMock.resultGetLocationsDetails = .success(responseMock)
        locationsDetailsPresenterMock.isFunctionWasCalled = false
        
        //When
        sut.getLocationsDetails(request: requestData)
        let result = locationsDetailsPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
    
    func testLocationsDetailsFailure() {
        //Given
        let requestData = LocationsDetailsModel.GetLocationsDetails.Request(woeid: 123)
        let failure : HomeError = .request

        locationsDetailsPresenterMock.resultGetLocationsDetails = .failure(failure)
        locationsDetailsPresenterMock.isFunctionWasCalled = false

        //When
        sut.getLocationsDetails(request: requestData)
        let result = locationsDetailsPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
}
