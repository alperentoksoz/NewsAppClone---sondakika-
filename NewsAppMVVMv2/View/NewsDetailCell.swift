//
//  NewsDetailCell.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 16.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

class NewsDetailCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "başlık"
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "newsimage")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "Description Description Description Description Description Description Description"
        
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "jane2")
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI() {
        
        let stack = UIStackView(arrangedSubviews: [titleLabel,imageView,descriptionLabel])
        stack.spacing = 16
        stack.axis = .vertical
        
        addSubview(stack)
        stack.anchor(top:topAnchor,left: leftAnchor,right: rightAnchor, paddingTop: 24)
    }
}
