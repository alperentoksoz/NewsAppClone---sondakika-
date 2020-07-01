//
//  SheetCell.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 25.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit


protocol SheetCellDelegate: class {
    func handleTextSizeChanged(forValue value: CGFloat)
}


class SheetCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: SheetCellDelegate?
    
    private lazy var homeNewCell = HomeNewCell()
    
    var settingsViewModel = SettingsViewModel(textSize: 16)
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ic_settings_24px")
        imageView.setDimensions(height: 24, width: 24)
        
        return imageView
    }()
    
    private let textSizeLabel = UILabel()
    
    lazy var textSizeSlider = createTextSizeSlider()
    
 
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        loadUserDefaults()
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleTextSizeChanged(sender: UISlider) {
        textSizeLabel.text = settingsViewModel.textSizeLabelText(forValue: sender.value)
        let textSize = settingsViewModel.textSizeConverCGFloat(forValue: sender.value)
        
        let textSizeDictionary = ["textSize": textSize]
        
        NotificationCenter.default
            .post(name: .notificationTextSize,
         object: nil, userInfo: textSizeDictionary)
        
        UserDefaults.standard.set(textSize, forKey: "textSize")
        
    }
    
    // MARK: - Helpers
    
    func loadUserDefaults() {
        let userDefaultSize = UserDefaults.standard.value(forKey: "textSize") as? Float ?? 24
        let textSize = settingsViewModel.textSizeConvertInt(forValue: userDefaultSize)
        textSizeLabel.text = "\(textSize) pt"
        textSizeSlider.value = userDefaultSize
    }
    
    func configureUI() {
        textSizeLabel.text = "16 pt"
        
        let stack = UIStackView(arrangedSubviews: [textSizeLabel,textSizeSlider])
        stack.spacing = 16
        stack.axis = .horizontal
        
        addSubview(stack)
        
        stack.centerY(inView: self)
        stack.anchor(left: leftAnchor,right: rightAnchor,paddingLeft: 24,paddingRight: 24)
        
    }
    
    func createTextSizeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 12
        slider.maximumValue = 44
        slider.addTarget(self, action: #selector(handleTextSizeChanged), for: .valueChanged)
        
        return slider
    }
}
