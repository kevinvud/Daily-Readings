//
//  ReflectionCategoriesCell.swift
//  Daily Readings
//
//  Created by PoGo on 12/6/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class ReflectionCategoriesCell: UICollectionViewCell {
    
    var rssReflectionCategories: ReflectionCategories? {
        didSet{
            guard let imageName = rssReflectionCategories?.imageName else {return}
            guard let title = rssReflectionCategories?.title else {return}
            guard let contentText = rssReflectionCategories?.contentText else {return}
            imageView.image = UIImage(named: imageName)
            createString(title: title, content: contentText)
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleAndText: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        return text
    }()
    
    let view: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if UIDevice.current.model == "iPhone" || UIDevice.current.model == "iPod"{
            
        }
        
        backgroundColor = .clear
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews() {
        addSubview(view)
        addSubview(imageView)
        addSubview(titleAndText)
        
        if #available(iOS 11.0, *) {
            imageView.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 150, height: 200)
            view.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 48, paddingLeft: 24, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
            titleAndText.anchor(top: view.topAnchor, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
            titleAndText.sizeToFit()
        } else {
            imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 150, height: 200)
            view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 48, paddingLeft: 24, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
            titleAndText.anchor(top: view.topAnchor, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
            titleAndText.sizeToFit()
        }
    }
    
    
    func createString(title: String, content: String){
        let attributedText = NSMutableAttributedString(string: "\(title)\n\n", attributes: [NSAttributedStringKey.font: UIFont.init(name: "HelveticaNeue-Bold", size: 20)!])
        attributedText.append(NSMutableAttributedString(string: content, attributes: [NSAttributedStringKey.font: UIFont.init(name: "Avenir Next", size: 16)!]))
        self.titleAndText.attributedText = attributedText
    }
}
