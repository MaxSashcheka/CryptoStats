//
//  SettingsViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 8.02.22.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: ViewController {

    @IBOutlet weak var settingsTableView: UITableView! {
        didSet {
            settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
            settingsTableView.delegate = self
            settingsTableView.dataSource = self
            settingsTableView.rowHeight = 50
            settingsTableView.backgroundColor = .secondarySystemBackground
            settingsTableView.isScrollEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    var viewModel: SettingsViewModel!
    
    override func bindData() {
        viewModel.settingsCellViewModels
            .asObservable()
            .bind(onNext: { [weak self] _ in
                self?.settingsTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
//    CenteredCollectionViewModel
//    selectedItems.accept(selectedItems.value + [items.value[index]])

    // Color
    // Currency
    //
}

// MARK: - SettingsViewController + UITableViewDelegate&UITableViewDataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath)
                as? SettingsCell else {
                    assertionFailure("Can`t deque reusable cell for identifier \(SettingsCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.settingsCellViewModels.value[indexPath.row]

        return cell
    }

}
