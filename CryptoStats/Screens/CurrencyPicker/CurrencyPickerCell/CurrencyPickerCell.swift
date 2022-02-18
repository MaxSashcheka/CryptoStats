//
//  CurrencyPickerCell.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 16.02.22.
//

import UIKit
import SnapKit

class CurrencyPickerCell: TableCell {
    let checkmarkImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    
    let titleLabel = UILabel()
    
    var viewModel: CurrencyPickerCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.attributedText = viewModel.title
            checkmarkImageView.isHidden = !viewModel.isSelected
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
    
    private func initialize() {
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkmarkImageView)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading)
                .offset(15)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        checkmarkImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).inset(10)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.size.equalTo(CGSize(width: 25, height: 25))
        }
    }
    
}
