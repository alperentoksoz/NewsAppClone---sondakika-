//
//  FeedController.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 15.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewsCell"

class FeedController: UICollectionViewController {
    // MARK: - Properties
    
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

        collectionView.register(HomeNewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        collectionView.backgroundColor = .systemPink
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
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeNewCell
        
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    print("DEBUG: \(collectionView.frame.width)")
    let cgSize = CGSize(width: collectionView.frame.width, height: 200)
    return cgSize
}
}
