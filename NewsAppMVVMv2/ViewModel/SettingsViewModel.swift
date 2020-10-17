
//
//  settingsViewModel.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 10.07.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

struct SettingsViewModel {
    
    
    var textSize: CGFloat
    
    init(textSize: CGFloat) {
        self.textSize = textSize
    }
    
    func textSizeLabelText(forValue value: Float) -> String {
        return "\(Int(value)) pt"
    }
    
    func textSizeConverCGFloat(forValue value: Float) -> CGFloat {
        return CGFloat(value)
    }
    
    func textSizeConvertInt(forValue value: Float) -> Int {
        return Int(value)
    }
}
