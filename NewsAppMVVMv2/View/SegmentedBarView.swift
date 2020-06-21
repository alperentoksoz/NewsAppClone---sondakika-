//
//  SegmentedBarView.swift
//  TinderCloneFinal
//
//  Created by Alperen Toksöz on 5.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit

class SegmentedBarView: UIStackView {
    
    
    init(numberOfSegments: Int) {
        super.init(frame: .zero)
        
        (0..<numberOfSegments).forEach { (_) in
            let barView = UIView()
            barView.backgroundColor = .barDeselectedColor
            addArrangedSubview(barView)
        }
        spacing = 4
        distribution = .fillEqually

        arrangedSubviews.first?.backgroundColor = .orange
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHightlighted(index: Int) {
        arrangedSubviews.forEach({ $0.backgroundColor = .barDeselectedColor })
        arrangedSubviews[index].backgroundColor = .orange
    }
}
