//
//  FeedController.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 15.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit
import JGProgressHUD

private let reuseIdentifier = "NewsCell"

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    var articleViewModels = [ArticleViewModel]()
    
    let navigationSettingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ic_settings_24px"), for: .normal)
        button.setDimensions(height: 40, width: 40)
        
        return button
    }()
    
    let navigationSideMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.checkmark, for: .normal)
        
        return button
    }()
    
//    let navigationSideMenuButton: UIButton = {
//        let button = UIButton(type: .system)
//
//        return button
//    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
        configureUI()
        collectionView.register(HomeNewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    // MARK: - API
    
    func fetchArticles() {

        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: view)
        
        Service.getArticles() { (articleList) in
            guard let articleList = articleList?.articles else { return }

            articleList.forEach { (article) in
                let articleViewmodel = ArticleViewModel(article: article)
                self.articleViewModels.append(articleViewmodel)

            }
            hud.dismiss()
            DispatchQueue.main.async {
                  self.collectionView.reloadData()
              }
        }

  
    }
    
    // MARK: - Selectors
    
    @objc func handleSettings() {
        print("DEBUG: Handle settings")
        configureNavigationBar()
    }
    
    @objc func handleLetterSize() {
        print("DEBUG: Handle letter size")
    }
    
    @objc func handleSideMenuShow() {
        print("DEBUG: Handle show side menu")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        configureNavigationBar()
        
    }
    
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.title = "Son Dakika"
        navigationController?.navigationBar.tintColor = .white

        let settingsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_settings_24px"), style: .plain, target: self, action: #selector(handleSettings))
        let letterSizeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_format_size_24px"), style: .plain, target: self, action: #selector(handleLetterSize))
        settingsButton.tintColor = .black
        letterSizeButton.tintColor = .black
        navigationItem.rightBarButtonItems = [settingsButton,letterSizeButton]
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_24px"), style: .plain, target: self, action: #selector(handleSideMenuShow))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
}

extension FeedController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(articleViewModels.count)
        return articleViewModels.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeNewCell

            let articleViewModel = articleViewModels[indexPath.row]

            cell.articleViewModel = articleViewModel

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = NewsDetailController(articleListViewModel: articleViewModels)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cgSize = CGSize(width: collectionView.frame.width, height: 150)
    return cgSize
}
}
