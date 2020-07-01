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
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        print("titlelabel")
        label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        loadUserDefaults()

        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTextSize(notification:)), name: .notificationTextSize, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func changeTextSize(notification: Notification) {
        print("\(notification.userInfo?["textSize"] as? CGFloat ?? 0 )")
        let size = notification.userInfo?["textSize"] as? CGFloat ?? 0
        titleLabel.font = UIFont.systemFont(ofSize: size)
        
        UserDefaults.standard.set(size, forKey: "textSize")
    }
    
    // MARK: - Helpers
    
    func configure() {
        titleLabel.text = articleViewModel?.article.title
        guard let resourceURL = articleViewModel?.article.urlToImage else { return }
        guard let url = URL(string: resourceURL) else { return }
        newsImageView.sd_setImage(with: url, completed: nil)
        timeLabel.text = articleViewModel?.timeStamp
        
        
    }
    
    func loadUserDefaults() {
        let textSize = UserDefaults.standard.value(forKey: "textSize") as? CGFloat ?? 24
        titleLabel.font = UIFont.systemFont(ofSize: textSize)
    }
    
    func configureUI() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
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


extension Notification.Name {
    static let notificationTextSize = Notification.Name(rawValue: "NotificationTextSize")
}

