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
    let priceUsd: Double
    let percentChangeUsdLast24Hours:Double
   
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case symbol
//        case name
//        case priceUsd
//        case last24HoursChange
//
//    }
}

