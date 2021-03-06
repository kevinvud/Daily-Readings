//
//  NewsFeedCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/7/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

protocol NewsFeedCellDelegate: class {
    func handleShareNewsPressed(newsTitle: String)
}

class NewsFeedCell: UICollectionViewCell {
    
    var descriptionString: String?
    var imageUrl: String?
    
    var descriptionLabelFontSize: CGFloat = 24
    var titleLabelFontSize: CGFloat = 30

    weak var delegate: NewsFeedCellDelegate?
    
    var item: RSSItem? {
        didSet{
            DispatchQueue.main.async {
                self.separatedString()
                self.titleLabel.text = self.item?.title
                self.setupLabelDisplayed()
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
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.clipsToBounds = true
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
        bt.addTarget(self, action: #selector(handleShareNews), for: .touchUpInside)
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
            titleLabelFontSize = 26
        }
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    

    func setupViews() {

        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(shareButton)
        
        
        if #available(iOS 11.0, *) {
            titleLabel.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: descriptionLabel.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
            descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: dateLabel.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
            dateLabel.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 8, paddingRight: 0, width: 250, height: 20)
            shareButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 15, width: 25, height: 25)
            
        } else {
            titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: descriptionLabel.topAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
            descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: dateLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
            dateLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 8, paddingRight: 0, width: 250, height: 20)
            shareButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 15, width: 25, height: 25)
        }
    }
    
    func setupLabelDisplayed(){
        guard let descriptionText = self.descriptionString else {return}
        let attributedText = NSMutableAttributedString(string: descriptionText, attributes: [NSAttributedStringKey.font: UIFont.init(name: "Avenir Next", size: descriptionLabelFontSize)!])
        self.descriptionLabel.attributedText = attributedText
    }
    
    func separatedString() {
        let stringSeparator = "<img src=\""
        guard let descriptionText = self.item?.description else {return}
        let contentArray = descriptionText.components(separatedBy: stringSeparator)
        if contentArray.count > 1 {
            let stringSeparator2 = "\" width=\"100"
            let contentArray2 = contentArray[1].components(separatedBy: stringSeparator2)
            self.imageUrl = contentArray2[0]
            if contentArray2.count > 1 {
                let stringSeparator3 = "border=\"0\">"
                let contentArray3 = contentArray2[1].components(separatedBy: stringSeparator3)
                if contentArray3.count > 1 {
                    self.descriptionString = contentArray3[1]
                }
            }
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
    
    @objc func handleShareNews() {
        guard let newsTitle = item?.title else {return}
        delegate?.handleShareNewsPressed(newsTitle: newsTitle)
    }
}
//
//
//import UIKit
//
//class NewsFeedCell: UICollectionViewCell {
//
//    var imageUrl: String?
//    var descriptionString: String?
//
//    var item: RSSItem? {
//        didSet{
//                self.separatedString()
//
//                DispatchQueue.main.async {
//                self.titleLabel.text = self.item?.title
//                self.setupDateLabel()
//                self.setupLabelDisplayed()
//            }
//        }
//    }
//    let titleLabel: UILabel = {
//
//        let lb = UILabel()
//        lb.numberOfLines = 0
//        lb.font = UIFont(name: "Helvetica", size: 25)
//        lb.font = UIFont.boldSystemFont(ofSize: 25)
//        return lb
//
//    }()
//    let descriptionLabel: UILabel = {
//        let lb = UILabel()
//        lb.clipsToBounds = true
//        lb.numberOfLines = 0
//        lb.font = UIFont(name: "Iowan", size: 17)
//        return lb
//
//    }()
//    let dateLabel: UILabel = {
//        let lb = UILabel()
//        lb.font = UIFont(name: "Athelas", size: 14)
//        return lb
//    }()
//    let lineSeparator: UIView = {
//        let line = UIView()
//        line.backgroundColor = UIColor.rgb(red: 190, green: 190, blue: 190)
//        return line
//
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = #colorLiteral(red: 0.9842278361, green: 0.9843688607, blue: 0.9841969609, alpha: 1)
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("fatal error in Daily cell")
//    }
//
//    func setupViews() {
//
//
//        let stackView = UIStackView(arrangedSubviews: [titleLabel,descriptionLabel,dateLabel])
//        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
//        stackView.spacing = 5
//
//
//        addSubview(stackView)
//        addSubview(lineSeparator)
//
//        if #available(iOS 11.0, *) {
//            stackView.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: lineSeparator.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
//            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
//        } else {
//            stackView.anchor(top: topAnchor, left: leftAnchor, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
//            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
//        }
//    }
//
//    func setupLabelDisplayed(){
//            guard let descriptionText = self.descriptionString else {return}
//        let attributedText = NSMutableAttributedString(string: descriptionText, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 140, green: 140, blue: 140)])
//            self.descriptionLabel.attributedText = attributedText
//
//    }
//
//    func separatedString() {
//
//        let stringSeparator = "<img src=\""
//        guard let descriptionText = self.item?.description else {return}
//        let contentArray = descriptionText.components(separatedBy: stringSeparator)
//        if contentArray.count > 1 {
//            let stringSeparator2 = "\" width=\"100"
//            let contentArray2 = contentArray[1].components(separatedBy: stringSeparator2)
//            self.imageUrl = contentArray2[0]
//            if contentArray2.count > 1 {
//                let stringSeparator3 = "border=\"0\">"
//                let contentArray3 = contentArray2[1].components(separatedBy: stringSeparator3)
//                if contentArray3.count > 1 {
//                    self.descriptionString = contentArray3[1]
//                }
//            }
//        }
//    }
//
//    func setupDateLabel() {
//
//        guard let dateFromUrl = self.item?.pubDate else {return}
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
//        guard let dateFromString = dateFormatter.date(from: dateFromUrl) else {return}
//
//        let datetest = dateFromString.timeAgoDisplay()
//        let attributedText = NSMutableAttributedString(string: "Ngày \(datetest)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .light)])
//        self.dateLabel.attributedText = attributedText
//
//
//    }
//
//
//
//}
//
//
