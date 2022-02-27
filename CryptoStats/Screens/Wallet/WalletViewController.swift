//
//  WalletViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 18.02.22.
//

import UIKit
import RxSwift
import RxCocoa

class WalletViewController: ViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(WalletInfoCollectionViewCell.nib, forCellWithReuseIdentifier: WalletInfoCollectionViewCell.reuseIdentifier)
            collectionView.register(WalletCoinCollectionViewCell.nib, forCellWithReuseIdentifier: WalletCoinCollectionViewCell.reuseIdentifier)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsVerticalScrollIndicator = false
        }
    }
    
    var viewModel: WalletViewModel!
    
    override var navigationItemTitle: String { "My wallet" }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func bindData() {
        viewModel.walletCoinsViewModels
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupViewModels()
    }


}

// MARK: - WalletViewController+UICollectionViewDelegate&UICollectionViewDataSource
extension WalletViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalletInfoCollectionViewCell.reuseIdentifier, for: indexPath)
                    as? WalletInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.showAddCoinScreenTransition = viewModel.showAddCoinTransition
            cell.viewModel = viewModel.walletInfoViewModel.value
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalletCoinCollectionViewCell.reuseIdentifier, for: indexPath)
                    as? WalletCoinCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.viewModel = viewModel.walletCoinsViewModels.value[indexPath.row]
            
            return cell
        }
        
    }
    
}

extension WalletViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = view.bounds.width - 30
        let itemHeight = (indexPath.section == 0) ? Constants.View.CollectionView.infoCellHeight : Constants.View.CollectionView.cellHeight
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Constants.View.CollectionView.insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.View.CollectionView.minimumLineSpacing
    }
}

private extension WalletViewController {
    enum Constants {
        enum View {
            enum CollectionView {
                static let insets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
                static let horizontalInsets = insets.left * 2
                static let minimumLineSpacing = insets.bottom
                static let infoCellHeight: CGFloat = 160
                static let cellHeight: CGFloat = 110
            }
        }
    }
}
