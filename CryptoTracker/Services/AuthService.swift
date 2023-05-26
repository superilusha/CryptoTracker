//
//  AuthService.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation

class AuthService {
    private let validUsername = "1234"
    private let validPassword = "1234"
    
    static let shared = AuthService()
    
    private init() {}
    
    func login(username: String, password: String, completion: @escaping (Result<(), Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            if username == self.validUsername && password == self.validPassword {
                completion(.success(()))
            } else {
                let error = NSError(domain: "AuthError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid username or password"])
                completion(.failure(error))
            }
        }
    }
}
