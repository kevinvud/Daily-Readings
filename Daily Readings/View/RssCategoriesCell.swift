//
//  RssCategoriesCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class RssCategoriesCell: UICollectionViewCell {
    
    
    var rssCategories: RssCategories? {
        didSet{
            guard let image = rssCategories?.imageName else {return}
            imageView.image = UIImage(named: image)
            title.text = rssCategories?.title
        }
        
        
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let title: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        lb.font = UIFont(name: "Georgia", size: 30)
        return lb
    }()
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(title)
        addSubview(lineSeparator)
        
        
        if #available(iOS 11.0, *) {
            imageView.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: lineSeparator.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            title.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 150)
            title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 3)
        } else {
            imageView.anchor(top: topAnchor, left: leftAnchor, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            title.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 150)
            title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 3)
        }
        
    }
    
}
