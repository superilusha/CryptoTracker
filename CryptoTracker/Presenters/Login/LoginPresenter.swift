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
    //    func login(username: String, password: String) {
    //        if authService.isValidCredentials(username: username, password: password) {
    //            // Если учетные данные верны, запускаем переход к списку монет, иначе выводим сообщение об ошибке.
    //            // Здесь вы должны реализовать собственный способ перехода к следующему экрану.
    //        } else {
    //            view?.showErrorMessage(message: "Неправильный логин или пароль. Пожалуйста, попробуйте снова.")
    //        }
    //    }
    
    func login(username: String, password: String, onSuccess: @escaping () -> Void) {
            authService.login(username: username, password: password) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        onSuccess()
                    case .failure(let error):
                        self?.view?.showErrorMessage(message: error.localizedDescription)
                    }
                }
            }
        }

    
//    private func navigateToCoinsList() {
//            let coinsListViewController = SceneRouter.route(scene: .coinsList)
//            DispatchQueue.main.async {
//                if let navigationController = self.view.navigationController {
//                    navigationController.setViewControllers([coinsListViewController], animated: true)
//                }
//            }
//        }

}
