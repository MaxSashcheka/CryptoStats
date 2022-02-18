//
//  ViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 16.02.22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ColorThemePickerViewController: ViewController {

    
    @IBOutlet weak var colorThemesCollectionView: UICollectionView! {
        didSet {
            colorThemesCollectionView.register(ColorThemeCollectionViewCell.self, forCellWithReuseIdentifier: ColorThemeCollectionViewCell.reuseIdentifier)
            colorThemesCollectionView.delegate = self
            colorThemesCollectionView.dataSource = self
        }
    }
    
    var viewModel: ColorThemePickerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }

}

extension ColorThemePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorThemeCollectionViewCell.reuseIdentifier, for: indexPath)
                as? ColorThemeCollectionViewCell else {
            assertionFailure("Can`t deque a reusable cell for \(ColorThemeCollectionViewCell.reuseIdentifier) identifier")
            return UICollectionViewCell()
        }
//        cell.backgroundColor = .green
        
        return cell
    }
}

extension ColorThemePickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        typealias CollectionView = Constants.View.CollectionView
        
        let paddingWidth = (CollectionView.itemsPerRow + 1) * CollectionView.insets.left
        let availableWidth = collectionView.frame.width - paddingWidth
        
        let itemWidth = availableWidth / CollectionView.itemsPerRow
        let itemHeight = itemWidth + 20
        print("Item width = \(itemWidth), Item height = \(itemHeight)")
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Constants.View.CollectionView.insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.View.CollectionView.insets.bottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.View.CollectionView.insets.bottom
    }
    
}

private extension ColorThemePickerViewController {
    enum Constants {
        enum View {
            enum CollectionView {
                static let itemsPerRow: CGFloat = 2
                static let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
                static let horizontalInsets = insets.left * 2
                static let verticalInsets = insets.top * 2
            }
        }
    }
}


