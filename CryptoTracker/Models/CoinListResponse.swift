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
        let marketcap: Marketcap
        
        struct MarketData: Codable {
            let price_usd: Double?
            let percent_change_usd_last_24_hours: Double?
            let percent_change_usd_last_1_hour: Double?
            let real_volume_last_24_hours: Double?
        }
        
        struct Marketcap: Codable {
            let current_marketcap_usd: Double?
            let rank: Int? 
        }
    }
}
