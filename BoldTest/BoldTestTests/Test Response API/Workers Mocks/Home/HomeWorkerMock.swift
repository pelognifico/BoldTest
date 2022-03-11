//
//  HomeWorkerMock.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import Foundation
@testable import BoldTest

class HomeWorkerMock : HomeServiceProtocol {
    
    var resultGetHome: (Result<[SearchLocationModel.GetSearchLocationQuery.Response], HomeError>)?
    
    var isFunctionWasCalled = false
    
    func getLocationQuery(request: SearchLocationModel.GetSearchLocationQuery.Request, completion: @escaping (Result<[SearchLocationModel.GetSearchLocationQuery.Response], HomeError>) -> Void) {
        if let result = resultGetHome {
            isFunctionWasCalled = true
            completion(result)
        }
    }
}
