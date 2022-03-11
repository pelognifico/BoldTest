//
//  HomePresentationLogicMock.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import Foundation
@testable import BoldTest

final class HomePresentationLogicMock: HomePresentationLogic {    
    
    var responseHome: SearchLocationModel.GetSearchLocationQuery.Response?
    var isFunctionWasCalled = false
    
    func presentLocationQuery(response: [SearchLocationModel.GetSearchLocationQuery.Response]) {
        if responseHome != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: SearchLocationModel.Error.Response) {
        isFunctionWasCalled = true
    }
}
