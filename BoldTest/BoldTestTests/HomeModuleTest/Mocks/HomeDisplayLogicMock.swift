//
//  HomeDisplayLogicMock.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import Foundation
@testable import BoldTest

final class HomeDisplayLogicMock: HomeDisplayLogic {
    
    var viewModelDisplayHome: SearchLocationModel.GetSearchLocationQuery.ViewModel?
    var isFunctionWasCalled = false
    
    func displayLocationQuery(viewModel: SearchLocationModel.GetSearchLocationQuery.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: SearchLocationModel.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}
