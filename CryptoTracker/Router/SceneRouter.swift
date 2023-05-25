//
//  SceneRouter.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation
import UIKit

enum Scene {
    case login
    case coinsList
}

class SceneRouter {
    static func route(scene: Scene) -> UIViewController {
        switch scene {
        case .login:
            return LoginViewController()
        case .coinsList:
            return CoinsListViewController()
        }
    }
}
