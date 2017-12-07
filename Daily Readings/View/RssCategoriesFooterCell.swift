//
//  RssCategoriesFooterCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/14/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class RssCategoriesFooterCell: UICollectionViewCell {
    
    lazy var button: UIButton = {
        let bt = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "Tin Công Giáo", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        attributedText.append(NSAttributedString(string: " được cung cấp bởi Trang Tin Báo Công Giáo", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)]))
        bt.setAttributedTitle(attributedText, for: .normal)
        bt.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
        bt.titleLabel?.numberOfLines = 0
        bt.titleLabel?.textColor = UIColor(white: 0.3, alpha: 1)
        return bt
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews() {
        addSubview(button)
        button.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width - 10, height: 40)
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    
    }
    
    @objc func handleTouch() {
        guard let url = URL(string: "http://baoconggiao.net/") else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
