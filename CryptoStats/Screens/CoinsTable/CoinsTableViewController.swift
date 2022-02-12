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
    
    @IBOutlet weak var coinsCollectionView: UICollectionView! {
        didSet {
            coinsCollectionView.register(CryptoCoinCell.nib, forCellWithReuseIdentifier: CryptoCoinCell.reuseIdentifier)
            coinsCollectionView.delegate = self
            coinsCollectionView.dataSource = self
        }
    }
    let coinsCollectionViewInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    
    var viewModel: CoinsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto coins"
        
        bindData()
        viewModel.fetchCryptoCoins()
    }

    @IBAction func buttonTapped(_ sender: Any) {
        openDetailScreenTransition?()
    }
    
    func bindData() {
        viewModel.cryptoCoinsViewModels
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.coinsCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

}


// MARK: CoinsTableViewController+UITableViewDelegate&UITableViewDataSource
extension CoinsTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cryptoCoinsViewModels.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CryptoCoinCell.reuseIdentifier, for: indexPath)
                as? CryptoCoinCell else {
            assertionFailure("Can`t deque reusable cell for \(CryptoCoinCell.reuseIdentifier) identifier")
            return UICollectionViewCell()
        }
        
        cell.viewModel = viewModel.cryptoCoinsViewModels.value[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        viewModel.selectItem(atIndex: indexPath.row)
    }
}

extension CoinsTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.bounds.width - coinsCollectionViewInsets.left * 2
        let height: CGFloat = 100
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        coinsCollectionViewInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        coinsCollectionViewInsets.bottom
    }
    
}


