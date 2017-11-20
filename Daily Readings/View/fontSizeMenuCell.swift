//
//  SettingsMenuInReadingsVCCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/19/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class fontSizeMenuCell: UICollectionViewCell {
    
    let slider: UISlider = {
        let sd = UISlider()
        sd.maximumValue = 72
        sd.minimumValue = 18
        return sd
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in fontSizeMenuCell cell")
    }
    
    
}
