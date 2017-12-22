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
    var todayMassFontSize: CGFloat = 28
    var contentTextViewHeight: CGFloat = 288
    var imageViewHeight: CGFloat = 512
    var shareButtonWidth: CGFloat = 100
    
    weak var delegate: DailyReadingsCellDelegate?
    
    var readingData: ReadingsContent? {
        didSet{
                if let imageViewUrl = self.readingData?.imageViewUrl{
                    self.imageView.loadImagesUsingCacheWithUrlString(imageViewUrl)
                }
                if let todayMass = self.readingData?.todayMass {
                    self.todayMass.text = "\(todayMass)"
                }
                if let dateLabelText = self.readingData?.dateLabel {
                    let VNDateFormatter = DateFormatter()
                    VNDateFormatter.dateFormat = "d MMMM yyyy"
                    VNDateFormatter.locale = Locale(identifier: "vi_VN")
                    guard let date = VNDateFormatter.date(from: dateLabelText) else {return}
                    
                    VNDateFormatter.dateFormat = "d MMMM"
                    VNDateFormatter.locale = Locale(identifier: "vi_VN")
                    let dateAfterShortened = VNDateFormatter.string(from: date)
                        self.dateLabel.text = "Ngày \(dateAfterShortened)"
                }
                if let todayLabelCheck = self.readingData?.checkTodayOrTomorrowOrYesterdayLabel {
                    self.todayLabel.text = todayLabelCheck
                    if todayLabelCheck == "Hôm Nay"{
                        self.todayLabel.backgroundColor = UIColor.rgb(red: 218, green: 207, blue: 239)
                        self.todayLabel.textColor = .white
                        self.todayLabel.textAlignment = .center
                    }else{
                        self.todayLabel.backgroundColor = .clear
                        self.todayLabel.textColor = UIColor.rgb(red: 143, green: 150, blue: 163)
                        self.todayLabel.textAlignment = .left
                    }
                    
                }
                self.setupLabelDisplayed()
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
        tf.font = UIFont.init(name: "HelveticaNeue-Bold", size: todayMassFontSize)
        tf.numberOfLines = 0
        return tf
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: textFontSize)
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
            todayMassFontSize = 22
            contentTextViewHeight = 150
            imageViewHeight = 250
            shareButtonWidth = 80
        }
        
        
        addSubview(imageView)
        addSubview(dateLabel)
        addSubview(todayMass)
        addSubview(todayLabel)
        addSubview(contentTextView)
        addSubview(shareButton)
        
        
        if #available(iOS 11.0, *) {
            
            imageView.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: imageViewHeight)
            
            todayMass.anchor(top: imageView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: todayLabel.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 10, paddingRight: 15, width: 0, height: 0)
            
            todayLabel.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 150, height: 30)
            
            contentTextView.anchor(top: todayLabel.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: contentTextViewHeight)
            
            dateLabel.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 10, paddingRight: 0, width: 0, height: 25)
            
            shareButton.anchor(top: nil, left: nil, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: shareButtonWidth, height: 25)
            shareButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor).isActive = true
            
        } else {
            imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: imageViewHeight)
            
            todayMass.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: todayLabel.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 10, paddingRight: 15, width: 0, height: 0)
            
            todayLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 150, height: 30)
            
            contentTextView.anchor(top: todayLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: contentTextViewHeight)
            
            dateLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 10, paddingRight: 0, width: 0, height: 25)
            
            shareButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: shareButtonWidth, height: 25)
            shareButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor).isActive = true
        }
    }
    
    
    func setupLabelDisplayed(){
        var firstReading = self.readingData?.reading1?.replacingOccurrences(of: "\r\n \r\n ", with: "\n")
        firstReading = firstReading?.replacingOccurrences(of: "\r\n \r\n", with: "\n")
        firstReading = firstReading?.replacingOccurrences(of: "\r\n\r\n ", with: "\n")
        firstReading = firstReading?.replacingOccurrences(of: "\r\n\r\n", with: "\n")
        firstReading = firstReading?.replacingOccurrences(of: "\r\n ", with: "\n")
        
        let attributedText = NSMutableAttributedString(string: "Bài Đọc 1: ", attributes: [NSAttributedStringKey.font : UIFont.init(name: "AvenirNext-Medium", size: self.textFontSize)!])
        attributedText.append(NSAttributedString(string: "\(firstReading ?? "")", attributes: [NSAttributedStringKey.font : UIFont.init(name: "Avenir Next", size: self.textFontSize)!]))
        self.contentTextView.attributedText = attributedText
        
    }
    
    @objc func handleShare() {
        guard let image = imageView.image else {return}
        guard let todayMass = todayMass.text else {return}
        guard let todayDate = dateLabel.text else {return}
        
        delegate?.handleSharePressed(image: image, todayDate: todayDate, todayMass: todayMass)
        
    }
    
}

