//
//  HomeAPI.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Foundation

protocol HomeServiceProtocol {
    func getLocationQuery(request: SearchLocationModel.GetSearchLocationQuery.Request, completion: @escaping (Result<[SearchLocationModel.GetSearchLocationQuery.Response], HomeError>) -> Void)
}

class HomeAPI: HomeServiceProtocol {
    
    func getLocationQuery(request: SearchLocationModel.GetSearchLocationQuery.Request, completion: @escaping (Result<[SearchLocationModel.GetSearchLocationQuery.Response], HomeError>) -> Void) {
        
        NetworkService.share.request(endpoint: HomeEndpoint.getLocationQuery(query: request.query)) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([SearchLocationModel.GetSearchLocationQuery.Response].self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
