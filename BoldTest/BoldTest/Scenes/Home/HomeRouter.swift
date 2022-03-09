//
//  HomeRouter.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 8/3/22.
//

import Foundation

@objc protocol HomeRoutingLogic {
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
  
}
