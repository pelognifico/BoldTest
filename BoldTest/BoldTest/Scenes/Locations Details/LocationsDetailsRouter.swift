//
//  LocationsDetailsRouter.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 9/3/22.
//

import Foundation

@objc protocol LocationsDetailsRoutingLogic {
}

protocol LocationsDetailsDataPassing {
    var dataStore: LocationsDetailsDataStore? { get }
}

class LocationsDetailsRouter: NSObject, LocationsDetailsRoutingLogic, LocationsDetailsDataPassing {
    weak var viewController: LocationsDetailsViewController?
    var dataStore: LocationsDetailsDataStore?
  
}
