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
            guard let imageName = rssCategories?.imageName else {return}
            guard let title = rssCategories?.title else {return}
            titleAndText.text = title
            imageView.image = UIImage(named: imageName)
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
        text.textAlignment = .center
        text.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
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
            titleAndText.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 140)
            titleAndText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 150, height: 200)
            view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 48, paddingLeft: 24, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
            titleAndText.anchor(top: view.topAnchor, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 140)
        }
    }
    
//    
//    func createString(title: String, content: String){
//        let attributedText = NSMutableAttributedString(string: "\(title)\n\n", attributes: [NSAttributedStringKey.font: UIFont.init(name: "HelveticaNeue-Bold", size: 20)!])
//        attributedText.append(NSMutableAttributedString(string: content, attributes: [NSAttributedStringKey.font: UIFont.init(name: "Avenir Next", size: 16)!]))
//        self.titleAndText.attributedText = attributedText
//    }

    
}

//var titleFontSize: CGFloat = 40
//
//var rssCategories: RssCategories? {
//    didSet{
//        guard let image = rssCategories?.imageName else {return}
//        imageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
//        imageView.tintColor = .white
//        title.text = rssCategories?.title
//    }
//}
//
//let imageView: UIImageView = {
//    let iv = UIImageView()
//    iv.contentMode = .scaleAspectFill
//    iv.clipsToBounds = true
//    return iv
//}()
//
//lazy var title: UILabel = {
//    let lb = UILabel()
//    lb.numberOfLines = 0
//    lb.textAlignment = .center
//    lb.textColor = .white
//    lb.layer.shadowColor = UIColor.black.cgColor
//    lb.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//    lb.layer.shadowRadius = 2.0
//    lb.layer.shadowOpacity = 1.0
//    lb.layer.masksToBounds = false
//    lb.font = UIFont(name: "AvenirNext-Bold", size: titleFontSize)
//    return lb
//}()
//let lineSeparator: UIView = {
//    let line = UIView()
//    line.backgroundColor = .white
//    return line
//
//}()
//
//
//override init(frame: CGRect) {
//    super.init(frame: frame)
//    if UIDevice.current.model == "iPhone" || UIDevice.current.model == "iPod"{
//        titleFontSize = 30
//    }
//
//    setupViews()
//}
//
//required init?(coder aDecoder: NSCoder) {
//    fatalError("fatal error in Daily cell")
//}
//
//func setupViews() {
//    addSubview(imageView)
//    addSubview(title)
//    addSubview(lineSeparator)
//
//
//    if #available(iOS 11.0, *) {
//        imageView.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 64, height: 64)
//        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        title.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 144)
//        title.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
//        lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
//    } else {
//        imageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 64, height: 64)
//        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        title.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 144)
//        title.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
//        lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
//    }
//
//}

