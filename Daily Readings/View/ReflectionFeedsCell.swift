//
//  ReflectionFeedsCell.swift
//  Daily Readings
//
//  Created by PoGo on 12/6/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

protocol ReflectionFeedsCellDelegate: class {
    func handleShareItemPressed(newsTitle: String)
}

class ReflectionFeedsCell: UICollectionViewCell {
    
    var imageUrl: String?
    
    var descriptionLabelFontSize: CGFloat = 22
    var titleLabelFontSize: CGFloat = 28
    
    weak var delegate: ReflectionFeedsCellDelegate?
    
    var item: RSSItem? {
        didSet{
            DispatchQueue.main.async {
                self.titleLabel.text = self.item?.title
                self.setupDateLabel()
            }
            
        }
        
    }
    
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "HelveticaNeue-Bold", size: titleLabelFontSize)
        lb.numberOfLines = 0
        return lb
        
    }()
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.init(white: 0.2, alpha: 1)
        return lb
    }()
    
    lazy var shareButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "shareNews").withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = UIColor.init(white: 0.2, alpha: 1)
        bt.imageView?.contentMode = .scaleAspectFill
        bt.addTarget(self, action: #selector(handleShareItem), for: .touchUpInside)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9842278361, green: 0.9843688607, blue: 0.9841969609, alpha: 1)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        
        if UIDevice.current.model == "iPhone" || UIDevice.current.model == "iPod"{
            descriptionLabelFontSize = 18
            titleLabelFontSize = 22
        }
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    
    func setupViews() {
        
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(shareButton)
        
        
        if #available(iOS 11.0, *) {
            titleLabel.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: dateLabel.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
            dateLabel.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 0, width: 250, height: 30)
            shareButton.anchor(top: nil, left: nil, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 25, height: 25)
            shareButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor).isActive = true
            
        } else {
            titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: dateLabel.topAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
            dateLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 0, width: 250, height: 30)
            shareButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 25, height: 25)
            shareButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor).isActive = true
        }
    }
    
    func setupDateLabel() {
        
        guard let dateFromUrl = self.item?.pubDate else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        guard let dateFromString = dateFormatter.date(from: dateFromUrl) else {return}
        
        let datetest = dateFromString.timeAgoDisplay()
        let attributedText = NSMutableAttributedString(string: "\(datetest)", attributes: [NSAttributedStringKey.font: UIFont.init(name: "AvenirNext-Regular", size: descriptionLabelFontSize)!])
        self.dateLabel.attributedText = attributedText
        
    }
    
    @objc func handleShareItem() {
        guard let newsTitle = item?.title else {return}
        delegate?.handleShareItemPressed(newsTitle: newsTitle)
    }
}
