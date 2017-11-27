//
//  DailyReadingsCell.swift
//  Daily Readings
//
//  Created by PoGo on 10/26/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

protocol DailyReadingsCellDelegate: class {
    func handleSharePressed(image: UIImage, todayDate: String, todayMass: String)
}

class DailyReadingsCell: UICollectionViewCell {
    
    var textFontSize: CGFloat = 24
    var dateLabelFontSize: CGFloat = 24
    var todayMassFontSize: CGFloat = 26
    var contentTextViewHeight: CGFloat = 100
    var imageViewHeight: CGFloat = 500
    weak var delegate: DailyReadingsCellDelegate?
    var readingData: ReadingsContent? {
        didSet{
            DispatchQueue.main.async {
                if let imageViewUrl = self.readingData?.imageViewUrl{
                    self.imageView.loadImagesUsingCacheWithUrlString(imageViewUrl)
                }
                if let todayMass = self.readingData?.todayMass {
                    self.todayMass.text = "\(todayMass)"
                    
                }
                if let dateLabel = self.readingData?.dateLabel {
                    
                    self.dateLabel.text = "\(dateLabel)"
                    
                }
                if let todayLabelCheck = self.readingData?.checkTodayOrTomorrowOrYesterdayLabel {
                    self.todayLabel.text = todayLabelCheck
                }
                self.setupLabelDisplayed()
            }
        }
    }
    
    let imageView: CustomImageVIew = {
        let iv = CustomImageVIew()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: dateLabelFontSize)
        label.textColor = UIColor.init(white: 0.2, alpha: 1)
        return label
    }()
    
    
    lazy var todayMass: UILabel = {
        let tf = UILabel()
        tf.adjustsFontSizeToFitWidth = true
        tf.font = UIFont.init(name: "AvenirNext-DemiBold", size: todayMassFontSize)
        tf.numberOfLines = 0
        return tf
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: textFontSize)
        label.textColor = UIColor.rgb(red: 143, green: 150, blue: 163)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    let contentTextView: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.isEditable = false
        tf.isUserInteractionEnabled = false
        tf.backgroundColor = .clear
        tf.textContainerInset = UIEdgeInsets.zero
        tf.textContainer.lineFragmentPadding = 0
        return tf
    }()
    
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.rgb(red: 140, green: 140, blue: 140)
        return line
        
    }()
    
    lazy var shareButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Share", for: .normal)
        bt.titleLabel?.font = UIFont.init(name: "AvenirNext-Medium", size: 18)
        bt.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        bt.setTitleColor(UIColor.rgb(red: 59, green: 104, blue: 198), for: .normal)
        bt.setImage(#imageLiteral(resourceName: "sharePost").withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = UIColor.rgb(red: 59, green: 104, blue: 198)
        bt.imageView?.contentMode = .scaleAspectFill
        bt.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.rgb(red: 255, green: 255, blue: 255)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews(){
        if UIDevice.current.model == "iPhone" || UIDevice.current.model == "iPod"{
            textFontSize = 18
            dateLabelFontSize = 18
            todayMassFontSize = 20
            contentTextViewHeight = 90
            imageViewHeight = 250
        }
        
        
        addSubview(imageView)
        addSubview(dateLabel)
        addSubview(todayMass)
        addSubview(todayLabel)
        addSubview(contentTextView)
        addSubview(shareButton)
        
        
        if #available(iOS 11.0, *) {
            dateLabel.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 20)
            
            imageView.anchor(top: dateLabel.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: imageViewHeight)
            
            todayMass.anchor(top: imageView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: todayLabel.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
            
            todayLabel.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 150, height: 30)
            
            contentTextView.anchor(top: todayLabel.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 150)
            
            shareButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 15, width: 80, height: 25)
            
        } else {
            dateLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 20)
            
            imageView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: imageViewHeight)
            
            todayMass.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: todayLabel.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
            
            todayLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 150, height: 30)
            
            contentTextView.anchor(top: todayLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 150)
            
            shareButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 15, paddingRight: 15, width: 80, height: 25)
        }
    }
    
    
    func setupLabelDisplayed(){
        DispatchQueue.main.async {
            guard let firstReading = self.readingData?.reading1 else {return}
            let attributedText = NSMutableAttributedString(string: "Bài Đọc 1: ", attributes: [NSAttributedStringKey.font : UIFont.init(name: "AvenirNext-Medium", size: self.textFontSize)!])
            attributedText.append(NSAttributedString(string: "\(firstReading)", attributes: [NSAttributedStringKey.font : UIFont.init(name: "Avenir Next", size: self.textFontSize)!]))
            self.contentTextView.attributedText = attributedText
        }
        
    }
    
    @objc func handleShare() {
        guard let image = imageView.image else {return}
        guard let todayMass = todayMass.text else {return}
        guard let todayDate = dateLabel.text else {return}
        
        delegate?.handleSharePressed(image: image, todayDate: todayDate, todayMass: todayMass)
        
    }
    
}

