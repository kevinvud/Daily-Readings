//
//  ReadingsDisplayCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/1/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit


class ReadingsDisplayCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        return lb
        
    }()
    
    let cellContentLabel: UITextView = {
        let label = UITextView()
        //        label.font = UIFont(name: "Avenir Next", size: textSize)
        label.isScrollEnabled = false
        label.isEditable = false
        label.textContainerInset = UIEdgeInsets.zero
        label.textContainer.lineFragmentPadding = 0
        label.backgroundColor = .clear
        return label
    }()
    
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.rgb(red: 190, green: 190, blue: 190)
        return line
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews(){
        addSubview(titleLabel)
        addSubview(cellContentLabel)
        addSubview(lineSeparator)
        
        if #available(iOS 11.0, *) {
            titleLabel.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor , bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 40)
            cellContentLabel.anchor(top: titleLabel.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: lineSeparator.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 3)
        } else {
            titleLabel.anchor(top: topAnchor, left: leftAnchor , bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 30)
            cellContentLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 3)
        }
    }
}

