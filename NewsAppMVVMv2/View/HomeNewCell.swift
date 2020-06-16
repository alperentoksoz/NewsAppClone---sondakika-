//
//  HomeNewCell.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 15.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit
import SDWebImage

class HomeNewCell: UICollectionViewCell {
    // MARK: - Properties
    
    var articleViewModel: ArticleViewModel? {
        didSet {
            configure()
        }
    }
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.setDimensions(height: 100, width: 100)
        imageView.image = #imageLiteral(resourceName: "newsimage")
        
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12,weight: .heavy)
        label.text = "14:45"
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configure() {
        titleLabel.text = articleViewModel?.article.title
        guard let url = URL(string: (articleViewModel?.article.urlToImage)!) else { return }
        newsImageView.sd_setImage(with: url, completed: nil)
    }
    
    func configureUI() {
        backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [timeLabel,titleLabel])
        stack.axis = .vertical
        stack.spacing = 20
        
        addSubview(stack)
        stack.anchor(top:topAnchor,left: leftAnchor,paddingTop: 16,paddingLeft: 16)
        
        addSubview(newsImageView)
        newsImageView.anchor(top:topAnchor,left: stack.rightAnchor,right: rightAnchor,paddingTop: 16, paddingLeft: 16,paddingRight: 16)
        
        
        
    }
}
