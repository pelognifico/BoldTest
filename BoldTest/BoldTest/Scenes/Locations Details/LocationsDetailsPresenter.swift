//
//  LocationsDetailsPresenter.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 9/3/22.
//

import Foundation

protocol LocationsDetailsPresentationLogic {
    func presentLocationsDetails(response: LocationsDetailsModel.GetLocationsDetails.Response)
    func presentError(response: SearchLocationModel.Error.Response)
}

class LocationsDetailsPresenter: LocationsDetailsPresentationLogic {
    
    weak var viewController: LocationsDetailsDisplayLogic?
  
    // MARK: - Present Places
    func presentLocationsDetails(response: LocationsDetailsModel.GetLocationsDetails.Response) {
        let viewModel = LocationsDetailsModel.GetLocationsDetails.ViewModel(consolidatedWeather: response)
        viewController?.displayLocationsDetails(viewModel: viewModel, on: .main)
    }
    
    // MARK: - Present Error
    func presentError(response: SearchLocationModel.Error.Response) {
        let viewModel = SearchLocationModel.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
