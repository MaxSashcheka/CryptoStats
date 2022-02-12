//
//  ViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 8.02.22.
//

import UIKit

class CoinsTableViewController: ViewController {
    
    var openDetailScreenTransition: VoidClosure?
    var cryptoCoinsAPIDataManager = CryptoCoinsAPIDataManager()
    private let networkService = DefaultNetworkService()
    var coins = [CryptoCoin]()
    
    @IBOutlet weak var coinsTableView: UITableView! {
        didSet {
            coinsTableView.register(CoinTableViewCell.nib, forCellReuseIdentifier: CoinTableViewCell.reuseIdentifier)
            coinsTableView.delegate = self
            coinsTableView.dataSource = self
//            coinsTableView.tableFooterView = UIView()
            coinsTableView.separatorColor = .red
            coinsTableView.rowHeight = 70
        }
    }
    
//    var viewModel: CoinsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto coins"
        let cryptoCoinsRequest = Requests.CryptoCoinsRequest()
        networkService.request(cryptoCoinsRequest) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let cryptoCoins):
                self.coins = cryptoCoins
                DispatchQueue.main.async {
                    self.coinsTableView.reloadData()
                }
                
            case .failure(let error): print(error.localizedDescription)
            }
            print("End")
        }
    }

    @IBAction func buttonTapped(_ sender: Any) {
        openDetailScreenTransition?()
    }

}


// MARK: CoinsTableViewController+UITableViewDelegate&UITableViewDataSource
extension CoinsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseIdentifier, for: indexPath)
                as? CoinTableViewCell else {
            assertionFailure("Cannot deque reusable cell for \(CoinTableViewCell.reuseIdentifier) identifier")
            return UITableViewCell()
        }
        cell.coinNameLabel.text = coins[indexPath.row].name
        cell.coinImageView.imageFromUrl(url: coins[indexPath.row].image)

        return cell
    }
    
    
}


