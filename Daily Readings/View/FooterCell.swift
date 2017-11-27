//
//  HeaderCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/2/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class FooterCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "bible").withRenderingMode(.alwaysTemplate)
        image.tintColor = .lightGray
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let displayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .lightGray
        let attributedText = NSMutableAttributedString(string: "Thiên Chúa ở cùng chúng ta\n", attributes: [NSAttributedStringKey.font : UIFont.init(name: "AvenirNext-Medium", size: 14)!])
        attributedText.append(NSAttributedString(string: "Amen.", attributes: [NSAttributedStringKey.font : UIFont.init(name: "AvenirNext-Medium", size: 14)!]))
        label.attributedText = attributedText
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews(){
        
        addSubview(imageView)
        addSubview(displayLabel
        )
        imageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 35, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        displayLabel.anchor(top: imageView.bottomAnchor, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 0, width: 250, height: 0)
        displayLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
