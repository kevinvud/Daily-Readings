//
//  MoreMenuCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/14/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class MoreMenuCell: UICollectionViewCell {
    
    override var isSelected: Bool{
        didSet{
            label.textColor =  isSelected ? UIColor.rgb(red: 59, green: 104, blue: 198) : UIColor.black
            imageView.tintColor = isSelected ? UIColor.rgb(red: 59, green: 104, blue: 198) : UIColor.black
        }
    }
    
    var data: MoreMenuItem? {
        didSet{
            DispatchQueue.main.async {
                self.label.text = self.data?.title
                guard let imageName = self.data?.imageName else {return}
                self.imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    
    let label: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.init(name: "Georgia", size: 17)
        lb.numberOfLines = 0
        return lb
    }()
    
    let imageView: UIImageView = {
        let im = UIImageView()
        im.tintColor = .black
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
        backgroundColor = #colorLiteral(red: 0.9842278361, green: 0.9843688607, blue: 0.9841969609, alpha: 1)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(label)
        addSubview(lineSeparator)

        if #available(iOS 11.0, *) {
            imageView.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            label.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        } else {
            imageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            label.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        }
        
    }
    
}
