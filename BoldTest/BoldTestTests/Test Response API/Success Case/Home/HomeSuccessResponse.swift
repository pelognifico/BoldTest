//
//  HomeSuccessResponse.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
@testable import BoldTest

class HomeSuccessResponse: XCTestCase {
    var sut: HomeAPI!
    var homeServiceProtocolMock: HomeWorkerMock!
    
    override func setUp() {
        homeServiceProtocolMock = HomeWorkerMock()
        sut = HomeAPI()
    }
    
    //MARK: -- Test Home
    func testGetPlacesDetailsSuccess(){
        //Given
        let requestData = SearchLocationModel.GetSearchLocationQuery.Request(query: "ABC")
        
        let dataMock = SearchLocationModel.GetSearchLocationQuery.Response(title: "ABC", location_type: "ABC", woeid: 123, latt_long: "ABC")
        let success : [SearchLocationModel.GetSearchLocationQuery.Response]? = .some([dataMock])
        
        //When
        homeServiceProtocolMock.resultGetHome = .success(success!)
        
        //Then
        sut.getLocationQuery(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response[0].title, dataMock.title)
                XCTAssertEqual(response[0].location_type, dataMock.location_type)
                XCTAssertEqual(response[0].woeid, dataMock.woeid)
                XCTAssertEqual(response[0].latt_long, dataMock.latt_long)
            case .failure(_):
                break
            }
        })
    }
}
