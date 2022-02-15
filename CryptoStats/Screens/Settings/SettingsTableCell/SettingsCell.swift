//
//  SettingsCell.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 15.02.22.
//

import UIKit
import SnapKit

class SettingsCell: TableCell {
    
    private let settingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }()
    private let titleLabel = UILabel()
    
    var viewModel: SettingsCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            settingImageView.image = viewModel.image
            titleLabel.attributedText = viewModel.title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
    }
    
    private func initialize() {
        selectionStyle = .none

        contentView.addSubview(settingImageView)
        contentView.addSubview(titleLabel)
        
        settingImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 35, height: 35))
            $0.leading.equalTo(contentView.snp.leading)
                .offset(15)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(settingImageView.snp.trailing)
                .offset(10)
        }
    }
}
