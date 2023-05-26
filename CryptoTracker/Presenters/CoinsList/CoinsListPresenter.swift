//
//  CoinsListPresenter.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation

class CoinsListPresenter {
    weak var viewController: CoinsListViewController?

    init(viewController: CoinsListViewController) {
        self.viewController = viewController
    }

    func logout() {
        UserDefaultsManager.shared.setUserLoggedIn(false)
        let loginViewController = SceneRouter.route(scene: .login)
        viewController?.navigationController?.setViewControllers([loginViewController], animated: true)
    }
}
