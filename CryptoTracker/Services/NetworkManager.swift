//
//  NetworkService.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation

struct NetworkManager {
    let baseURL = "https://data.messari.io/api/v1/assets"
    
    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> Void) {let coinIDs = ["bitcoin", "ethereum", "ripple", "binancecoin", "cardano"]
        let coinIDsString = coinIDs.joined(separator: ",")

        let urlString = "\(baseURL)?ids=\(coinIDsString)%fields=id,symbol,name,metrics/market_data/price_usd,metrics/market_data/percent_change_usd_last_24_hours"

        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let coinResponse = try jsonDecoder.decode(CoinListResponse.self, from: data)
                        
                        let coins = coinResponse.data.map { coinResponse -> Coin in
                            return Coin(id: coinResponse.id,
                                        symbol: coinResponse.symbol,
                                        name: coinResponse.name)
                        }
                                        
                        completion(.success(coins))

                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }

    }
}
