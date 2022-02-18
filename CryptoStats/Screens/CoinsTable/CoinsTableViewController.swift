//
//  ViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 8.02.22.
//

import UIKit
import RxSwift
import RxCocoa

class CoinsTableViewController: ViewController {
    
    var openDetailScreenTransition: StringClosure?
    var showCryptoCoinDetailsClosure: StringClosure?
    
    @IBOutlet weak var coinsCollectionView: UICollectionView! {
        didSet {
            coinsCollectionView.register(CryptoCoinCell.nib, forCellWithReuseIdentifier: CryptoCoinCell.reuseIdentifier)
            coinsCollectionView.delegate = self
            coinsCollectionView.dataSource = self
        }
    }
    
    var viewModel: CoinsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.Title.title
        
        bindData()
        viewModel.fetchCryptoCoins()
    }

    override func bindData() {
        viewModel.cryptoCoinsViewModels
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.coinsCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

}


// MARK: - CoinsTableViewController+UITableViewDelegate&UITableViewDataSource
extension CoinsTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cryptoCoinsViewModels.value.count
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
        viewModel.selectItem(atIndex: indexPath.row)
    }
}

extension CoinsTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.bounds.width - Constants.View.CollectionView.verticalInsets
        let height: CGFloat = Constants.View.CollectionView.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Constants.View.CollectionView.insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.View.CollectionView.insets.bottom
    }
    
}

private extension CoinsTableViewController {
    enum Constants {
        enum Title {
            static let title = "Crypto coins"
        }
        enum View {
            enum CollectionView {
                static let insets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
                static let horizontalInsets = insets.left * 2
                static let verticalInsets = insets.top * 2
                static let height: CGFloat = 100
            }
        }
    }
}


