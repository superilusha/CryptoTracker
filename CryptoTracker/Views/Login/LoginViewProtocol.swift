//
//  LoginViewProtocol.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation


protocol LoginView: AnyObject {
    func showErrorMessage(message: String)
}
