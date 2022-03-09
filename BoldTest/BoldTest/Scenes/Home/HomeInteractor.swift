//
//  HomeInteractor.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 8/3/22.
//

import Foundation

protocol HomeBusinessLogic {
    func getLocationQuery(request: SearchLocationModel.GetSearchLocationQuery.Request)
}

protocol HomeDataStore {
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeServiceProtocol
    
    init(worker: HomeServiceProtocol = HomeAPI()) {
        self.worker = worker
    }
  
    // MARK: - Methods
    func getLocationQuery(request: SearchLocationModel.GetSearchLocationQuery.Request) {
        worker.getLocationQuery(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentLocationQuery(response: response)
            case .failure(let error):
                let response = SearchLocationModel.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        }
    }
}
