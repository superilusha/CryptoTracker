//
//  NetworkService.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation

struct NetworkManager {
    let baseURL = "https://data.messari.io/api/v1/assets"
    
    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> Void) {
        let coinIDs = ["btc", "eth", "sol", "xrp", "cardano", "tron", "polkadot", "dogecoin", "tether", "stellar"]
        var coins: [Coin] = []
        let group = DispatchGroup()
        
        for coinID in coinIDs {
            group.enter()
            
            let urlString = "\(baseURL)/\(coinID)/metrics"
            
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        completion(.failure(error))
                        group.leave()
                        return
                    }
                    
                    if let data = data {
                        do {
                            let jsonDecoder = JSONDecoder()
                            let coinResponse = try jsonDecoder.decode(CoinListResponse.self, from: data)
                            
                            let coin = Coin(id: coinResponse.data.id,
                                            symbol: coinResponse.data.symbol,
                                            name: coinResponse.data.name,
                                            priceUsd: coinResponse.data.market_data.price_usd ?? 0,
                                            percentChangeUsdLast24Hours: coinResponse.data.market_data.percent_change_usd_last_24_hours ?? 0,
                                            percentChangeUsdLast1Hour: coinResponse.data.market_data.percent_change_usd_last_1_hour ?? 0,
                                            volume: coinResponse.data.market_data.real_volume_last_24_hours ?? 0,
                                            marketcap: coinResponse.data.marketcap.current_marketcap_usd ?? 0,
                                            marketcapRank: coinResponse.data.marketcap.rank ?? 0)

                            
                            coins.append(coin)
                            
                            group.leave()
                        } catch {
                            completion(.failure(error))
                            group.leave()
                        }
                    }
                }
                task.resume()
            }
        }
        
        group.notify(queue: .main) {
            completion(.success(coins))
        }
    }
}
