//
//  Coin.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation

struct Coin: Codable {
    let id: String
    let symbol: String
    let name: String
    //let priceUsd: Double?
    //let oneDayChange: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        //case priceUsd = "price_usd"
        //case oneDayChange = "percent_change_usd_last_24_hours"
    }
}

