//
//  CoinTableViewCell.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation
import UIKit

class CoinTableViewCell: UITableViewCell {
    

    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:"coinCell")
        
        // Настраиваем UI-элементы
        [nameLabel, symbolLabel, priceLabel, changeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        // Устанавливаем размеры шрифтов и полужирность
        nameLabel.font = UIFont.systemFont(ofSize: 14.0)
        symbolLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        // Задаем расположение UI-элементов
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            symbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),

            nameLabel.leadingAnchor.constraint(equalTo: symbolLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 1),

            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),

            changeLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8),
            changeLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coin: Coin) {
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceLabel.text = String(format: "$%.2f", coin.priceUsd)
        changeLabel.text = String(format: "%.2f%%", coin.percentChangeUsdLast24Hours)
        changeLabel.textColor = coin.percentChangeUsdLast24Hours >= 0 ? .systemGreen : .systemRed
    }
}
