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
    let percentChangeUsdLast1Hour: Double
    let volume: Double
    let marketcap: Double
    let marketcapRank: Int
   
    
}

