//
//  WalletAddCoinViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 26.02.22.
//

import SnapKit
import RxSwift
import RxCocoa
import UIKit

class WalletAddCoinViewController: ViewController {
    
    private let coinsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AddCryptoCoinCell.self, forCellReuseIdentifier: AddCryptoCoinCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 55
        
        return tableView
    }()
    
    private let closeButton: UIImageView = {
        let button = UIImageView()
        button.image = UIImage(systemName: "xmark.circle")
        button.tintColor = .darkGray
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let addCoinsButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Add 0 coins to wallet", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.custom(font: .montserrat, size: 26, type: .medium)
        button.layer.cornerRadius = 12
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.5
        button.addTarget(self, action: #selector(addCoins), for: .touchUpInside)
        return button
    }()
    
    var viewModel: WalletAddCoinViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
        bindData()
        viewModel.fetchCryptoCoins()
    }
    
    override func bindData() {
        viewModel.cryptoCoinsViewModels
            .asDriver()
            .drive(onNext: { [weak self] coins in
                let selectedCoins = coins.compactMap { coin -> AddCryptoCoinCellViewModel? in
                    return coin.isSelected ? coin : nil
                }
                self?.setupAddCoinsButton(isEnabled: !selectedCoins.isEmpty, count: selectedCoins.count)
                
                self?.coinsTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

}

private extension WalletAddCoinViewController {
    func setupContent() {
        setupSelf()
        setupTableView()
        addSubviews()
        setupViewConstraints()
    }
    
    func setupSelf() {
        view.backgroundColor = .secondarySystemBackground
//        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeScreen)))
    }
    
    func setupTableView() {
        coinsTableView.delegate = self
        coinsTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(coinsTableView)
//        view.addSubview(closeButton)
        view.addSubview(addCoinsButton)
    }
    
    func setupViewConstraints() {
//        closeButton.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(15)
//            $0.trailing.equalToSuperview().inset(15)
//            $0.size.equalTo(35)
//        }
        
        addCoinsButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        coinsTableView.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview()
            $0.top.equalTo(addCoinsButton.snp.bottom).offset(10)
        }
    }
    
    func setupAddCoinsButton(isEnabled: Bool, count: Int) {
        addCoinsButton.isEnabled = isEnabled
        let color: UIColor = isEnabled ? .black : .lightGray
        addCoinsButton.setTitleColor(color, for: .normal)
        addCoinsButton.layer.borderColor = color.cgColor
        addCoinsButton.setTitle("Add \(count) coins to wallet", for: .normal)

    }
    
    @objc func closeScreen() {
//        dismiss(animated: true)
        viewModel.dismissTransition?()
    }
    
    @objc func addCoins() {
        viewModel.addCoins()
//        dismiss(animated: true)
    }
}

// MARK: - WalletAddCoinViewController+UITableViewDelegate&UITableViewDataSource
extension WalletAddCoinViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddCryptoCoinCell.reuseIdentifier, for: indexPath)
                as? AddCryptoCoinCell else { return UITableViewCell() }
        
        cell.viewModel = viewModel.cryptoCoinsViewModels.value[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath)
    }
    
    
}

class CustomButton: UIButton {
    override var intrinsicContentSize: CGSize {
        super.intrinsicContentSize.increaseWidth(by: 20)
    }
}


