//
//  CoinsListViewController.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation
import UIKit

class CoinsListViewController: UIViewController {
    
    private enum SortMode {
        case noSort
        case ascending
        case descending
    }

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "coinCell")
        return table
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let tickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ticker", for: .normal)
        return button
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Price", for: .normal)
        return button
    }()
    
    private let changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change 24h", for: .normal)
        return button
    }()

    private var coins: [Coin] = []
    
    private var currentTickerSort = SortMode.noSort
    private var currentPriceSort = SortMode.noSort
    private var currentChangeSort = SortMode.noSort
    
    private var presenter: CoinsListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CoinsListPresenter(viewController: self)

        setupLogoutButton()
        
        navigationItem.title = "Coins"
        view.addSubview(tableView)
        view.addSubview(tickerButton)
        view.addSubview(priceButton)
        view.addSubview(changeButton)
        
        tickerButton.addTarget(self, action: #selector(tickerButtonTapped), for: .touchUpInside)
        priceButton.addTarget(self, action: #selector(priceButtonTapped), for: .touchUpInside)
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "coinCell")
        tableView.refreshControl = refreshControl

        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        setupSortButtonsLayout()
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 20
        }

         func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let label = UILabel()
            label.text = ""
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .black
            label.backgroundColor = .white

            return label
        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        fetchCoins()
    }

    private func setupSortButtonsLayout() {
        let safeArea = view.safeAreaLayoutGuide
        [tickerButton, priceButton, changeButton].forEach { button in
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tickerButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            tickerButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            
            priceButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            priceButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            
            changeButton.trailingAnchor.constraint(equalTo: priceButton.leadingAnchor, constant: -16),
            changeButton.centerYAnchor.constraint(equalTo: priceButton.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: tickerButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func refreshTableView() {
          fetchCoins() {
              self.refreshControl.endRefreshing()
          }
      }

      private let refreshControl: UIRefreshControl = {
          let refreshControl = UIRefreshControl()
          refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
          return refreshControl
      }()

      private func setupLogoutButton() {
          let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonPressed))
          navigationItem.rightBarButtonItem = logoutBarButtonItem
      }
      
      @objc private func logoutButtonPressed() {
          presenter.logout()
      }
      
      private func fetchCoins(completion: (() -> Void)? = nil) {
          let networkManager = NetworkManager()
          loadingIndicator.startAnimating()

          networkManager.fetchCoins() { [weak self] result in
              DispatchQueue.main.async {
                  self?.loadingIndicator.stopAnimating()

                  switch result {
                  case .success(let coins):
                      self?.coins = coins
                      self?.tableView.reloadData()
                  case .failure(let error):
                      print("Error fetching coins: \(error.localizedDescription)")
                  }
                  if let completion = completion {
                      completion()
                  }
              }
          }
      }
      
      @objc func tickerButtonTapped() {
          switch currentTickerSort {
          case .noSort, .ascending:
              coins.sort { $0.symbol < $1.symbol }
              currentTickerSort = .descending
          case .descending:
              coins.sort { $0.symbol > $1.symbol }
              currentTickerSort = .ascending
          }
          tableView.reloadData()
      }

      @objc func priceButtonTapped() {
          switch currentPriceSort {
          case .noSort, .ascending:
              coins.sort { $0.priceUsd < $1.priceUsd }
              currentPriceSort = .descending
          case .descending:
              coins.sort { $0.priceUsd > $1.priceUsd }
              currentPriceSort = .ascending
          }
          tableView.reloadData()
      }

      @objc func changeButtonTapped() {
          switch currentChangeSort {
          case .noSort, .ascending:
              coins.sort { $0.percentChangeUsdLast24Hours < $1.percentChangeUsdLast24Hours }
              currentChangeSort = .descending
          case .descending:
              coins.sort { $0.percentChangeUsdLast24Hours > $1.percentChangeUsdLast24Hours }
              currentChangeSort = .ascending
          }
          tableView.reloadData()
      }
  }

extension CoinsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = coins[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath) as! CoinTableViewCell
        cell.configure(with: coin)
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let coin = coins[indexPath.row]
            let coinDetailViewController = CoinDetailViewController(coin: coin)
            navigationController?.pushViewController(coinDetailViewController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }

}
