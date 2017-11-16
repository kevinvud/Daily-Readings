//
//  DailyReadingsCell.swift
//  Daily Readings
//
//  Created by PoGo on 10/26/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

protocol DailyReadingsCellDelegate {
    func handleSharePressed(image: UIImage, todayDate: String, todayMass: String)
}

class DailyReadingsCell: UICollectionViewCell {
    
    let screenSize: CGRect = UIScreen.main.bounds
    var textFontSize: CGFloat = 22
    var dateLabelFontSize: CGFloat = 26
    var todayMassFontSize: CGFloat = 24
    var contentTextViewHeight: CGFloat = 150
    var imageViewHeight: CGFloat = 450
    var delegate: DailyReadingsCellDelegate?
    var readingData: ReadingsContent? {
        
        didSet{
            
            if let imageViewUrl = readingData?.imageViewUrl{
                    self.imageView.loadImagesUsingCacheWithUrlString(imageViewUrl)
            }
            if let todayMass = readingData?.todayMass {
                DispatchQueue.main.async {
                    self.todayMass.text = "\(todayMass)"
                }
            }
            if let dateLabel = readingData?.dateLabel {
                DispatchQueue.main.async {
                    self.dateLabel.text = "\(dateLabel)"
                }
                
            }
            if let todayLabelCheck = readingData?.checkTodayOrTomorrowOrYesterdayLabel {
                DispatchQueue.main.async {
                if todayLabelCheck == "Bài Đọc Hôm Nay" {
                        self.todayLabel.backgroundColor = UIColor.rgb(red: 218, green: 207, blue: 239)
                        self.todayLabel.textColor = .black
                        self.todayLabel.layer.cornerRadius = 10
                        self.todayLabel.clipsToBounds = true
                        self.todayLabel.text = "  \(todayLabelCheck)  "
                    } else {
                    DispatchQueue.main.async {
                        self.todayLabel.backgroundColor = .clear
                        self.todayLabel.textColor = .black
                        self.todayLabel.layer.cornerRadius = 0
                        self.todayLabel.clipsToBounds = false
                        self.todayLabel.text = "\(todayLabelCheck)"
                    }
                }
                }
            }
            setupLabelDisplayed()
        }
    }
    
    let imageView: CustomImageVIew = {
       let iv = CustomImageVIew()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: dateLabelFontSize)
        label.font = UIFont.boldSystemFont(ofSize: dateLabelFontSize)
        return label
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: UIFont.Weight.light)
        return label
    }()
    
    lazy var todayMass: UITextView = {
        let tf = UITextView()
        tf.font = UIFont.systemFont(ofSize: textFontSize, weight: UIFont.Weight.medium)
        tf.textColor = .red
        tf.isScrollEnabled = false
        tf.isEditable = false
        tf.isUserInteractionEnabled = true
        tf.textContainerInset = UIEdgeInsets.zero
        tf.textContainer.lineFragmentPadding = 0
        return tf
    }()
    
    let contentTextView: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.isEditable = false
        tf.isUserInteractionEnabled = true
        tf.textContainerInset = UIEdgeInsets.zero
        tf.textContainer.lineFragmentPadding = 0
        return tf
    }()
    
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
        
    }()
    
    lazy var readMoreLabel : UILabel = {
        let lb = UILabel()
        let attributedText = NSMutableAttributedString(string: "...", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: textFontSize)])
        attributedText.append(NSAttributedString(string: " Đọc Thêm", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: textFontSize, weight: .medium), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        lb.attributedText = attributedText
        return lb
        
    
    }()
    
    lazy var shareButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "shareImage").withRenderingMode(.alwaysOriginal), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFill
        bt.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews(){
        
        if screenSize.width < 768 {
            textFontSize = 18
            dateLabelFontSize = 22
            todayMassFontSize = 20
            contentTextViewHeight = 80
            imageViewHeight = 250
        }
        
        addSubview(imageView)
        addSubview(todayMass)
        addSubview(contentTextView)
        addSubview(dateLabel)
        addSubview(todayLabel)
        addSubview(lineSeparator)
        addSubview(readMoreLabel)
        addSubview(shareButton)
 

        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: imageViewHeight)
        dateLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
        todayLabel.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
        todayLabel.sizeToFit()
        todayMass.anchor(top: todayLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
        contentTextView.anchor(top: todayMass.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: contentTextViewHeight)
        readMoreLabel.anchor(top: contentTextView.bottomAnchor, left: leftAnchor, bottom: nil , right: rightAnchor, paddingTop: -15, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 20)
      
        shareButton.anchor(top: nil, left: nil, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 15, width: 25, height: 25)
        lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 10)
        
    }
    
    
    func setupLabelDisplayed(){
        DispatchQueue.main.async {
            guard let firstReading = self.readingData?.reading1 else {return}
            let attributedText = NSMutableAttributedString(string: "Bài Đọc 1: ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: self.textFontSize)])
            attributedText.append(NSAttributedString(string: "\(firstReading)", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: self.textFontSize)]))
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
