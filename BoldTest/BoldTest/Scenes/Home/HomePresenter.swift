//
//  HomePresenter.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 8/3/22.
//

import Foundation

protocol HomePresentationLogic {
    func presentLocationQuery(response: [SearchLocationModel.GetSearchLocationQuery.Response])
    func presentError(response: SearchLocationModel.Error.Response)
}

class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
  
    // MARK: - Present Places
    func presentLocationQuery(response: [SearchLocationModel.GetSearchLocationQuery.Response]) {
        let viewModel = SearchLocationModel.GetSearchLocationQuery.ViewModel(data: response)
        viewController?.displayLocationQuery(viewModel: viewModel, on: .main)
    }
    
    // MARK: - Present Error
    func presentError(response: SearchLocationModel.Error.Response) {
        let viewModel = SearchLocationModel.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
