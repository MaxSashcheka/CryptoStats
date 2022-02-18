//
//  ColorThemePickerViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 16.02.22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CurrencyPickerViewController: ViewController {

    private let currenciesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CurrencyPickerCell.self, forCellReuseIdentifier: CurrencyPickerCell.reuseIdentifier)
        tableView.rowHeight = 50
        return tableView
    }()
    
    var viewModel: CurrencyPickerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        bindData()
    }
    
    private func setupTableView() {
        view.addSubview(currenciesTableView)
        currenciesTableView.delegate = self
        currenciesTableView.dataSource = self
        currenciesTableView.snp.makeConstraints { $0.edges.equalTo(view.snp.edges) }
        
    }
    
    override func bindData() {
        viewModel.curreniesViewModels
            .asObservable()
            .bind(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    print("Updating")
                    self?.currenciesTableView.reloadData()
                }
                
            })
            .disposed(by: disposeBag)
    }

}

// MARK: - CurrencyPickerViewController + UITableViewDelegate & UITableViewDataSource

extension CurrencyPickerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "All prices in the app will be shown using choosed currency"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        return label
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyPickerCell.reuseIdentifier, for: indexPath) as? CurrencyPickerCell else {
            assertionFailure("Can not deque reusable cell with identifier \(CurrencyPickerCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.curreniesViewModels.value[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCell(at: indexPath)
    }
    
}
