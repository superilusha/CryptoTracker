//
//  AuthService.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation

class AuthService {
    private let vaildUsername = "1234"
    private let validPassword = "1234"
    
    static let shared = AuthService()
    
    private init() {}
    
    func isValidCredentials(username: String, password: String) -> Bool {
        return username == vaildUsername && password == validPassword
    }
}
