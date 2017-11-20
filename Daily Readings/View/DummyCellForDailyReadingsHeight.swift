//
//  DummyCellForDailyReadingsHeight.swift
//  Daily Readings
//
//  Created by PoGo on 11/16/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class DummyCellForDailyReadingsHeight: UICollectionViewCell {
    
    let cellContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(cellContentLabel)
        cellContentLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }

}
