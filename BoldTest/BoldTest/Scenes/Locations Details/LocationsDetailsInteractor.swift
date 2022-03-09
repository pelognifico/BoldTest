//
//  LocationsDetailsInteractor.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 9/3/22.
//

import Foundation

protocol LocationsDetailsBusinessLogic {
    func getLocationsDetails(request: LocationsDetailsModel.GetLocationsDetails.Request)
}

protocol LocationsDetailsDataStore {
}

class LocationsDetailsInteractor: LocationsDetailsBusinessLogic, LocationsDetailsDataStore {
    
    var presenter: LocationsDetailsPresentationLogic?
    var worker: LocationsDetailsServiceProtocol
    
    init(worker: LocationsDetailsServiceProtocol = LocationsDetailsAPI()) {
        self.worker = worker
    }
  
    // MARK: - Methods
    func getLocationsDetails(request: LocationsDetailsModel.GetLocationsDetails.Request) {
        worker.getLocationsDetails(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentLocationsDetails(response: response)
            case .failure(let error):
                let response = SearchLocationModel.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        }
    }
}
