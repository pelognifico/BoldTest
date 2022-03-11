//
//  LocationsDetailsFailureResponse.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
@testable import BoldTest

class LocationsDetailsFailureResponse: XCTestCase {
    var sut: LocationsDetailsAPI!
    var locationsDetailsServiceProtocolMock: LocationsDetailsWorkerMock!
    
    override func setUp() {
        locationsDetailsServiceProtocolMock = LocationsDetailsWorkerMock()
        sut = LocationsDetailsAPI()
    }
    
    //MARK: -- Test LocationsDetailsFailure
    func testGetLocationsDetailsFailure(){
        //Given
        let requestData = LocationsDetailsModel.GetLocationsDetails.Request(woeid: 123)
        let failure : HomeError = .request
        
        //When
        locationsDetailsServiceProtocolMock.resultGetLocationsDetails = .failure(failure)
        
        //Then
        sut.getLocationsDetails(request: requestData, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, failure.localizedDescription)
            }
        })
    }
    
}
