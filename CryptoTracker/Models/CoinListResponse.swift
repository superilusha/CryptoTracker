//
//  CoinListResponse.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 26.05.2023.
//

import Foundation


struct CoinListResponse: Codable {
    let data: CoinResponse
    
    struct CoinResponse: Codable {
        let id: String
        let symbol: String
        let name: String
        let market_data: MarketData
        
        struct MarketData: Codable {
            let price_usd: Double?
            let percent_change_usd_last_24_hours: Double?
        }
    }
}
