//
//  LoginViewController.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, LoginView, UITextFieldDelegate {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "CryptoTracker"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()

    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, usernameTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private lazy var presenter = LoginPresenterImpl(view: self, authService: AuthService.shared)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupUI()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    private func setupUI() {
        view.addSubview(inputStackView)
        view.addSubview(forgotPasswordButton)

        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            inputStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            inputStackView.widthAnchor.constraint(equalToConstant: 300),

            forgotPasswordButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: 20),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func showErrorMessage(message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @objc private func loginButtonPressed() {
        presenter.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] in
            // Успешная авторизация, переходим к следующему экрану
            let coinsListViewController = SceneRouter.route(scene: .coinsList)
            self?.navigationController?.pushViewController(coinsListViewController, animated: true)
        }
    }

    @objc private func forgotPasswordButtonPressed() {
        // Здесь можно заменить сообщение на данные пользователя
        let message = "Логин: 1234\nПароль: 1234"

        let alertController = UIAlertController(title: "Ваши данные", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField === passwordTextField {
            loginButtonPressed()
        }
        return true
    }
}

