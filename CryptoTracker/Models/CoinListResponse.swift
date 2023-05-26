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
        
    }
}
