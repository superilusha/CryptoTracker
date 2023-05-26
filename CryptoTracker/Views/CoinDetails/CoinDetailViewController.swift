//
//  CoinDetailsViewController.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation
import UIKit

class CoinDetailViewController: UIViewController {

    private let coin: Coin

    // Создайте UILabel для каждого поля
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // ... другие UILabel для остальных полей

    init(coin: Coin) {
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Установите цвет фона и кнопку возврата
        view.backgroundColor = .white
        navigationItem.title = "Coin Details"

        // Добавьте и конфигурируйте метки на экране
        setupLabels()
    }

    private func setupLabels() {
        // Здесь мы настраиваем метки (например, nameLabel) и добавляем их на экран.
        // Мы также устанавливаем значения меток с помощью данных из объекта Coin
        // Пример ниже для nameLabel, добавьте и настройте код для остальных меток аналогичным образом

        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        nameLabel.text = "Name: \(coin.name)"
        // ... настройка и добавление остальных меток
    }
}
