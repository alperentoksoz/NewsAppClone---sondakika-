//
//  Setting.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 24.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation

enum SettingsHeaders: Int, CaseIterable {
    case settings
    case about
    case support
    
    var description: String {
        switch self {
        case .settings: return "Application Settings"
        case .about: return "About"
        case .support: return "Support"
        }
    }
}

enum AppSettingsMenuList: Int, CaseIterable {
    case notification
    case autoVideo
    case displaySettings
    
    var description: String {
        switch self {
        case .notification: return "Notification Settings"
        case .autoVideo: return "Videos Auto Play"
        case .displaySettings: return "Display Settings"
        }
        
    }
}

enum AboutMenuList: Int, CaseIterable {
    case webSite
    case twitterAdress
    case facebookAdress
    
    var description: String {
        switch self {
        case .webSite: return "newsnewsnews.com"
        case .twitterAdress: return "@newsnewsnewscom"
        case .facebookAdress: return "facebook.com/newsnewsnewscom"
        }
    }
}

enum SupportMenuList: Int, CaseIterable {
    case feedBackSend
    case rateApp
    case versionApp
    
    var description: String {
        switch self {
        case .feedBackSend: return "Send feedback"
        case .rateApp: return "Rate for App"
        case .versionApp: return "Version"
    }
}

}
