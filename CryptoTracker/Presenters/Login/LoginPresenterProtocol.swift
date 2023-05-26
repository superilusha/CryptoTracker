//
//  LoginPresenterProtocol.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation

// Протокол LoginPresenter представляет собой контракт между Presenter и ViewController.
protocol LoginPresenter {
    func login(username: String, password: String, onSuccess: @escaping () -> Void)

}
