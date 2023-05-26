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

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let hourlyChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let dailyChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    init(coin: Coin) {
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Coin Details"

        setupLabels()
    }
        
    private func setupLabels() {
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(marketCapLabel)
        view.addSubview(volumeLabel)
        view.addSubview(hourlyChangeLabel)
        view.addSubview(dailyChangeLabel)
        view.addSubview(rankLabel)

        NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
                priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                hourlyChangeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
                hourlyChangeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                hourlyChangeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                dailyChangeLabel.topAnchor.constraint(equalTo: hourlyChangeLabel.bottomAnchor, constant: 16),
                dailyChangeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                dailyChangeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                volumeLabel.topAnchor.constraint(equalTo: dailyChangeLabel.bottomAnchor, constant: 16),
                volumeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                volumeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                marketCapLabel.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 16),
                marketCapLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                marketCapLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                rankLabel.topAnchor.constraint(equalTo: marketCapLabel.bottomAnchor, constant: 16),
                rankLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                rankLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)

        ])

        nameLabel.text = "Coin: \(coin.name)"
        priceLabel.text = "Price: \(String(format: "$%.2f", coin.priceUsd))"
        dailyChangeLabel.text = "24h Change: \(String(format: "%.2f%%", coin.percentChangeUsdLast24Hours))"
        marketCapLabel.text = "Market Capitalization: \(String(format: "$%.2f", coin.marketcap))"
        volumeLabel.text = "Real Volume: \(String(format: "$%.2f", coin.volume))"
        hourlyChangeLabel.text = "1h Change: \(String(format: "%.2f%%", coin.percentChangeUsdLast1Hour))"
        rankLabel.text = "Capitalization Rank №: \(coin.marketcapRank)"
       
    }
}
