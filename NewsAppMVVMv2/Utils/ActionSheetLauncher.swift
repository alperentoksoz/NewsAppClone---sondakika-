//
//  ActionSheetLauncher.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 25.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SheetCell"

protocol ActionSheetLauncherDelegate: class {
    func handleTextSizeChanged(forValue value: CGFloat)
}

class ActionSheetLauncher: NSObject, UITableViewDelegate {
    
    // MARK: - Properties
    
    
    weak var delegate: ActionSheetLauncherDelegate?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var window: UIWindow?
    private var tableViewHeight: CGFloat?
    
    private lazy var blackView: UIView = {
         let view = UIView()
         view.alpha = 0
         view.backgroundColor = UIColor(white: 0, alpha: 0.5)
         
         let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
         view.addGestureRecognizer(tap)
         return view
     }()
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        configureTableView()
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.tableView.frame.origin.y += 300
        }
    }
    
    // MARK: - Helpers
    
    func showTableView(_ shouldShow: Bool) {
        guard let window = window else { return }
        guard let height = tableViewHeight else { return }
        let y = shouldShow ? window.frame.height - height : window.frame.height
        tableView.frame.origin.y = y
    }
    
    func show() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        self.window = window
        
        window.addSubview(blackView)
        blackView.frame = window.frame
        
        window.addSubview(tableView)
        let height = CGFloat(2 * 60) + 100
        self.tableViewHeight = height
        tableView.layer.cornerRadius = 20
        tableView.frame = CGRect(x: 20, y: window.frame.height - 200 ,width: window.frame.width - 40, height: height)
        
        
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
            self.showTableView(true)
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.isScrollEnabled = false
        
        tableView.register(SheetCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource

extension ActionSheetLauncher: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Text Size"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SheetCell
        
        cell.delegate = self
    
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["Feed Page"]
    }
    
}


extension ActionSheetLauncher: SheetCellDelegate {
    func handleTextSizeChanged(forValue value: CGFloat) {

            delegate?.handleTextSizeChanged(forValue: value)

    }
}
