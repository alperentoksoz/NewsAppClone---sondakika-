//
//  NewsDetailCell.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 16.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

protocol NewsDetailCellDelegate: class {
    func handleSwipe(sender: UISwipeGestureRecognizer)
}

class NewsDetailCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: NewsDetailCellDelegate?
    
    var articleViewModel: ArticleViewModel? {
        didSet { configure() }
    }

    lazy var contentViewSize = CGSize(width: self.frame.width, height: 1000 )
    
    lazy var containerView: UIView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.bounds
        view.bounces = false
        view.contentSize = contentViewSize
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.isPagingEnabled = true
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.contentOffset.x = 0.0
        view.backgroundColor = .white
        view.isScrollEnabled = true
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Header"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        label.text = "Content.. Content.."
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .yellow
        print("height: \(frame.height)")
        configure()
        configureUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTextSize(notification:)), name: .notificationTextSize, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleSwipes(sender: UISwipeGestureRecognizer) {
        print("swiped")
        delegate?.handleSwipe(sender: sender)
    }
    
    @objc func changeTextSize(notification: Notification) {
        print("DEBUG: \(notification.userInfo?["textSize"] as? CGFloat ?? 0 )")
        let size = notification.userInfo?["textSize"] as? CGFloat ?? 0
        contentLabel.font = UIFont.systemFont(ofSize: size)

    }

    
    // MARK: - Helpers
    
    func configure() {
        titleLabel.text = articleViewModel?.article.title
        guard let resourceUrl = articleViewModel?.article.urlToImage else { return }
        guard let url = URL(string: resourceUrl) else { return }
        imageView.sd_setImage(with: url, completed: nil)
        contentLabel.text = articleViewModel?.article.content
        contentLabel.text?.append((articleViewModel?.article.content)!)
        contentLabel.text?.append((articleViewModel?.article.content)!)
    }
    
    func configureUI() {
        addSubview(scrollView)
        scrollView.fillSuperview()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))

        leftSwipe.direction = .left
        rightSwipe.direction = .right

        containerView.addGestureRecognizer(leftSwipe)
        containerView.addGestureRecognizer(rightSwipe)

        contentLabel.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(containerView)
    
        
        imageView.setDimensions(height: 300, width: frame.width)
        let stack = UIStackView(arrangedSubviews: [titleLabel,imageView])
        stack.spacing = 32
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(stack)
        stack.anchor(top: containerView.topAnchor,left: containerView.leftAnchor,right: containerView.rightAnchor, paddingTop: 32)

        containerView.addSubview(contentLabel)

        contentLabel.anchor(top: stack.bottomAnchor,left: containerView.leftAnchor,right: containerView.rightAnchor,paddingTop: 16, paddingLeft: 16,paddingRight: 16)


    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }

    
    
}


