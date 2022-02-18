//
//  ColorThemeCollectionViewCell.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 18.02.22.
//

import UIKit
import SnapKit

class ColorThemeCollectionViewCell: CollectionCell {
    
    private let colorThemeView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let colorThemeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.custom(font: .montserrat, size: 20, type: .bold)
        label.textColor = .darkGray
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        setupSelf()
        
        contentView.addSubview(colorThemeView)
        contentView.addSubview(colorThemeNameLabel)
        
        colorThemeNameLabel.text = "White theme"
        
        colorThemeView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
        
        colorThemeNameLabel.snp.makeConstraints {
            $0.top.equalTo(colorThemeView.snp.bottom).offset(3)
            $0.bottom.equalToSuperview().inset(3)
            $0.centerX.equalTo(colorThemeView)
        }
    }
    
    private func setupSelf() {
        let randomInt = Int.random(in: 0...1)
        backgroundColor = .white
        
//        layer.shadowOffset = .zero
//        layer.shadowRadius = 4.0
//        layer.shadowOpacity = 1
        layer.cornerRadius = 20
        layer.borderWidth = 1.5
        if randomInt == 0 {
            layer.borderColor = UIColor.darkGray.cgColor
        } else {
            layer.borderColor = UIColor.red.cgColor
            layer.borderWidth = 3

        }
        
    }
    
    
}
