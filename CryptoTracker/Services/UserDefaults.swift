//
//  UserDefaults.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 26.05.2023.
//

import Foundation

class UserDefaultsManager {
    
    private enum UserDefaultsKeys: String {
        case isLoggedIn
    }

    static let shared = UserDefaultsManager()

    private init() {}

    func setUserLoggedIn(_ loggedIn: Bool) {
        UserDefaults.standard.set(loggedIn, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

}
