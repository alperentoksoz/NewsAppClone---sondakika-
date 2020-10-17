//
//  SettingsController.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 23.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SettingCell"

class SettingsController: UITableViewController {
    
    
    // MARK: - Properties
    
    private let headerView = SettingsHeader()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .orange
        navigationController?.navigationBar.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
    }
}

extension SettingsController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.size.width, height: 20))

        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = SettingsHeaders(rawValue: section)?.description
        mainView.addSubview(label)

        
        return mainView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsHeaders.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return AppSettingsMenuList.allCases.count
        case 1: return AboutMenuList.allCases.count
        case 2: return SupportMenuList.allCases.count
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.imageView?.image = #imageLiteral(resourceName: "ic_settings_24px")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0: cell.textLabel?.text = AppSettingsMenuList(rawValue: indexPath.row)?.description
        case 1: cell.textLabel?.text = AboutMenuList(rawValue: indexPath.row)?.description
        case 2: cell.textLabel?.text = SupportMenuList(rawValue: indexPath.row)?.description
        default: break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: print("Tapped Notification Settings")
            case 1: print("Tapped Video settings")
            case 2: print("Tapped Display settings")
            default: break
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0: print("Go to webSite")
            case 1: print("Go to twitterAdress")
            case 2: print("Go to facebookAdress")
            default:
                break
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0: print("FeedBack Sending tapped")
            case 1: print("Vote App tapped")
            case 2: print("App version tapped")
            default:
                break
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension SettingsController: SettingsHeaderDelegate {
    func dismissAl() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
