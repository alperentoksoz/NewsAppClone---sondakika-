//
//  SettingsHeader.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 23.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

protocol SettingsHeaderDelegate: class {
    func dismissAl()
}

class SettingsHeader: UIView {
    // MARK: - Properties
    
    weak var delegate: SettingsHeaderDelegate?
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "news-logo")
        image.setDimensions(height: 100, width: 100)
        
        return image
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ic_keyboard_arrow_down_24px"), for: .normal)
        button.tintColor = .white
        button.setDimensions(height: 32, width: 32)
        button.addTarget(self, action: #selector(dismissAll), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func dismissAll() {
        delegate?.dismissAl()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = UIColor.orange.withAlphaComponent(0.2)
        addSubview(logo)
        logo.centerX(inView: self)
        logo.anchor(top:topAnchor,paddingTop: 16)
        
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor,right: rightAnchor,paddingTop: 16,paddingRight: 16)
    }
}
