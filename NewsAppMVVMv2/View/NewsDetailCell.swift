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
    
    var articleViewModel: ArticleViewModel? {
        didSet { configure() }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "başlık"
        label.textAlignment = .center
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "newsimage")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "Description Description Description Description Description Description Description"
        
        
        return label
    }()

    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        configure()
        configureUI()
        
//        imageView.contentMode = .scaleAspectFill
//        imageView.image = #imageLiteral(resourceName: "newsimage")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configure() {
        titleLabel.text = articleViewModel?.article.title
        guard let resourceUrl = articleViewModel?.article.urlToImage else { return }
        guard let url = URL(string: resourceUrl) else { return }
        imageView.sd_setImage(with: url, completed: nil)
        contentLabel.text = articleViewModel?.article.content
    }
    
    func configureUI() {

        imageView.setDimensions(height: 300, width: frame.width)
        let stack = UIStackView(arrangedSubviews: [titleLabel,imageView,contentLabel])
        stack.spacing = 32
        stack.axis = .vertical

        addSubview(stack)
        stack.anchor(top:topAnchor,left: leftAnchor,right: rightAnchor, paddingTop: 32,paddingLeft: 10,paddingRight: 10)

        

    }

    
    
}


