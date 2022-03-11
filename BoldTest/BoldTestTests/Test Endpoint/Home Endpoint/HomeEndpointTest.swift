//
//  HomeEndpointTest.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
@testable import BoldTest

class HomeEndpointTest: XCTestCase {
    var sut: HomeEndpoint!
    
    //MARK: - GET METHOD
    
    func testGetLocationQuery() {
        sut = .getLocationQuery(query: "san")

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "location/search/?query=san")
        XCTAssertNil(sut.parameter)
    }
}
