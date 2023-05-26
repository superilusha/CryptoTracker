//
//  CoinsListViewController.swift
//  CryptoTracker
//
//  Created by Илья Аношин on 25.05.2023.
//

import Foundation
import UIKit

class CoinsListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "coinCell")
        return table
    }()
    
    private var coins: [Coin] = []
    
    private var presenter: CoinsListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CoinsListPresenter(viewController: self)

        setupLogoutButton()
        
        navigationItem.title = "Coins"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "coinCell")
        tableView.refreshControl = refreshControl


        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coins.removeAll()
            tableView.reloadData()
            
            fetchCoins()

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
        
        networkManager.fetchCoins() { [weak self] result in
            DispatchQueue.main.async {
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
}
