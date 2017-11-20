//
//  HeaderCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/2/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    var sectionTitle: Section?{
        
        didSet{
            headerLabel.text = sectionTitle?.sectionTitle
        }
    }
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9842278361, green: 0.9843688607, blue: 0.9841969609, alpha: 1)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews(){
        addSubview(headerLabel)
        if #available(iOS 11.0, *) {
            headerLabel.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        } else {
            headerLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
    }
}
