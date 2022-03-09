//
//  GeneralRoute.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 8/3/22.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case home
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .home:
            return HomeViewController()
        }
    }
}
