//
//  ReadingsDisplayCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/1/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class ReadingsDisplayCell: UICollectionViewCell {
    
    let cellContentLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.isScrollEnabled = false
        label.isEditable = false
        label.backgroundColor = .clear
        return label
    }()
    
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        return line

    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews(){
        addSubview(cellContentLabel)
        addSubview(lineSeparator)
        lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 1)
        cellContentLabel.anchor(top: topAnchor, left: leftAnchor, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
    }
}
