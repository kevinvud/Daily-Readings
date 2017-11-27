//
//  DummyCellForDailyReadingsHeight.swift
//  Daily Readings
//
//  Created by PoGo on 11/16/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class DummyCellForDailyReadingsHeight: UICollectionViewCell {
    
    var todayMassFontSize: CGFloat = 26
    
    lazy var cellContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: todayMassFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if UIDevice.current.model == "iPhone" || UIDevice.current.model == "iPod"{
            todayMassFontSize = 20
        }
        
        addSubview(cellContentLabel)
        
        if #available(iOS 11.0, *) {
            cellContentLabel.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
        } else {
            cellContentLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }

}
