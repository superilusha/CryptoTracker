//
//  LoginPresenter.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation

class LoginPresenterImpl: LoginPresenter {

    private weak var view: LoginView?
    private let authService: AuthService

    // Здесь мы инициализируем объект LoginPresenterImpl с ссылкой на view и сервисом авторизации.
    init(view: LoginView, authService: AuthService) {
        self.view = view
        self.authService = authService
    }

    // Функция-обработчик ввода логина и пароля.
    func login(username: String, password: String) {
        if authService.isValidCredentials(username: username, password: password) {
            // Если учетные данные верны, запускаем переход к списку монет, иначе выводим сообщение об ошибке.
            // Здесь вы должны реализовать собственный способ перехода к следующему экрану.
        } else {
            view?.showErrorMessage(message: "Неправильный логин или пароль. Пожалуйста, попробуйте снова.")
        }
    }
}
