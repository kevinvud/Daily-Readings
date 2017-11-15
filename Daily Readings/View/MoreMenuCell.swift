//
//  MoreMenuCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/14/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class MoreMenuCell: UICollectionViewCell {
    
    let label: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.text = "Test"
        return lb
    }()
    
    let imageView: UIImageView = {
        let im = UIImageView()
        im.image = #imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal)
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.rgb(red: 190, green: 190, blue: 190)
        return line
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(label)
        addSubview(lineSeparator)

        imageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 30)
        label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        
    }
    
}
