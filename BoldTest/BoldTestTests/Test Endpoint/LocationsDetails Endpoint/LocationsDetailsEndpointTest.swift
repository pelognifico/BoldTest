//
//  LocationsDetailsEndpointTest.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
@testable import BoldTest

class LocationsDetailsEndpointTest: XCTestCase {
    var sut: LocationsDetailsEndpoint!
    
    //MARK: - GET METHOD
    
    func testGetLocationsDetails() {
        sut = .getLocationsDetails(woeid: 44418)

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "location/44418/")
        XCTAssertNil(sut.parameter)
    }
}
