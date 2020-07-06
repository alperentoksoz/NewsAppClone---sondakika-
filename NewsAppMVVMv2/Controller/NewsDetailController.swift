//
//  NewsDetailController.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 16.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewsDetailCell"

class NewsDetailController: UIViewController {
    
    // MARK: - Properties
    
    var articleViewModels = [ArticleViewModel]()
    
    private var selectedIndexPath: Int!
    
    private lazy var barStackView = SegmentedBarView(numberOfSegments: articleViewModels.count)
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: 800)
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(NewsDetailCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 30
        button.setTitle("< Headlines", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissAl), for: .touchUpInside)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 30
        button.setImage(#imageLiteral(resourceName: "ic_share_24px"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackBottomButtons: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = UIColor.white.withAlphaComponent(0)
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(backButton)
        stack.addArrangedSubview(shareButton)
        return stack
    }()
    
    // MARK: - Lifecycle
    
    init(articleListViewModel: [ArticleViewModel], indexPath: Int) {
        self.articleViewModels = articleListViewModel
        selectedIndexPath = indexPath
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        let indexPath = IndexPath(item: selectedIndexPath, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: false)
        let articleViewModel = articleViewModels[indexPath.item]
        let captionHeight = articleViewModel.size(forWidth: view.frame.width).height
        
        collectionView.frame = CGRect(x: 0, y: 80, width: view.frame.width, height: captionHeight + 850)
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Selectors
    
    @objc func dismissAl() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleShare() {
        let activityController = UIActivityViewController(activityItems: [articleViewModels[selectedIndexPath].article.url], applicationActivities: nil)
        present(activityController,animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(mainView)
        mainView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor, paddingTop: 14, paddingLeft: 88, paddingRight: 88, width: 40,height: 20)
        
        mainView.addSubview(barStackView)
        barStackView.fillSuperview()
        
        view.addSubview(collectionView)
        view.backgroundColor = .white
        
        view.addSubview(stackBottomButtons)
        stackBottomButtons.anchor(left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 16,paddingBottom: 32,paddingRight: 16, height: 60)
        backButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
}

extension NewsDetailController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        barStackView.setHightlighted(index: indexPath.row)
    }
}


extension NewsDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsDetailCell
        
        cell.delegate = self
        
        let articleViewModel = articleViewModels[indexPath.item]
        
        cell.articleViewModel = articleViewModel
        
        return cell
    }
    
}

extension NewsDetailController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let articleViewModel = articleViewModels[indexPath.item]
        let captionHeight = articleViewModel.size(forWidth: view.frame.width).height
        print("TEST: \(indexPath.row) \(captionHeight)")
        return CGSize(width: collectionView.bounds.size.width, height: captionHeight + 850)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension NewsDetailController: NewsDetailCellDelegate {
    func handleSwipe(sender: UISwipeGestureRecognizer) {
        
        if sender.direction == .left {
            print("swiped left")
            let indexPath = IndexPath(item: selectedIndexPath - 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at:[.centeredVertically, .centeredHorizontally], animated: true)
            selectedIndexPath = selectedIndexPath - 1
        } else if sender.direction == .right {
              print("swiped right")
            let indexPath = IndexPath(item: selectedIndexPath + 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at:[.centeredVertically, .centeredHorizontally], animated: true)
            selectedIndexPath = selectedIndexPath + 1
        }
        
        
    }
}
