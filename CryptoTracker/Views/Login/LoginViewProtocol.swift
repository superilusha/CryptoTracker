//
//  LoginViewProtocol.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation

// Протокол LoginView представляет собой контракт между ViewController и Presenter.
protocol LoginView: AnyObject {
    func showErrorMessage(message: String)
}
