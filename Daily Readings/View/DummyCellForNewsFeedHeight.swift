//
//  DummyCellForNewsFeedHeight.swift
//  Daily Readings
//
//  Created by PoGo on 12/4/17.
//  Copyright © 2017 PoGo. All rights reserved.
//


import UIKit

class DummyCellForNewsFeedHeight: UICollectionViewCell {
    
    var todayMassFontSize: CGFloat = 30
    var descriptionLabelFontSize: CGFloat = 24
    
    lazy var cellContentLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont.init(name: "HelveticaNeue-Bold", size: todayMassFontSize)
        return lb
    }()
    
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.clipsToBounds = true
        lb.font = UIFont.init(name: "Avenir Next", size: descriptionLabelFontSize)
        lb.numberOfLines = 0
        return lb
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if UIDevice.current.model == "iPhone" || UIDevice.current.model == "iPod"{
            todayMassFontSize = 26
            descriptionLabelFontSize = 18
        }
        
        addSubview(cellContentLabel)
        addSubview(descriptionLabel)
        
        if #available(iOS 11.0, *) {
            cellContentLabel.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: descriptionLabel.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
                 descriptionLabel.anchor(top: cellContentLabel.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        } else {
            cellContentLabel.anchor(top: topAnchor, left: leftAnchor, bottom: descriptionLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
            descriptionLabel.anchor(top: cellContentLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        }
   
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
}


