//
//  HomeFailureResponse.swift
//  BoldTestTests
//
//  Created by Carlos Villamizat on 10/3/22.
//

import XCTest
@testable import BoldTest

class HomeFailureResponse: XCTestCase {
    var sut: HomeAPI!
    var homeServiceProtocolMock: HomeWorkerMock!
    
    override func setUp() {
        homeServiceProtocolMock = HomeWorkerMock()
        sut = HomeAPI()
    }
    
    //MARK: -- Test HomeFailure
    func testGetHomeFailure(){
        //Given
        let requestData = SearchLocationModel.GetSearchLocationQuery.Request(query: "ABC")
        let failure : HomeError = .request
        
        //When
        homeServiceProtocolMock.resultGetHome = .failure(failure)
        
        //Then
        sut.getLocationQuery(request: requestData, completion: { result in
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
