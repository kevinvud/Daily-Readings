//
//  DailyReadingsCell.swift
//  Daily Readings
//
//  Created by PoGo on 10/26/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class DailyReadingsCell: UICollectionViewCell {
    
    var readingData: ReadingsContent? {
        
        didSet{
            if let imageViewUrl = readingData?.imageViewUrl{
                    self.imageView.loadImagesUsingCacheWithUrlString(imageViewUrl)
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
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let todayLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        return label
    }()
    
    
    let contentTextView: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.isEditable = false
        tf.isUserInteractionEnabled = false
        tf.textContainerInset = UIEdgeInsets.zero
        tf.textContainer.lineFragmentPadding = 0;
        return tf
    }()
    
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
        
    }()
    
    let readMoreLabel : UILabel = {
        let lb = UILabel()
        let attributedText = NSMutableAttributedString(string: "...", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedText.append(NSAttributedString(string: " Đọc Thêm", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: .medium), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        lb.attributedText = attributedText
        return lb
        
    
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
        
        addSubview(imageView)
        addSubview(contentTextView)
        addSubview(dateLabel)
        addSubview(todayLabel)
        addSubview(lineSeparator)
        addSubview(readMoreLabel)
 

        
        todayLabel.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        todayLabel.sizeToFit()
        
        
        dateLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
    
        contentTextView.anchor(top: todayLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 100)
        
        readMoreLabel.anchor(top: contentTextView.bottomAnchor, left: leftAnchor, bottom: imageView.topAnchor, right: rightAnchor, paddingTop: -5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: 0, height: 20)
        
        imageView.anchor(top: nil, left: leftAnchor, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 8)
        
    }
    
    
    func setupLabelDisplayed(){
        DispatchQueue.main.async {
            guard let firstReading = self.readingData?.reading1 else {return}
            
            let attributedText = NSMutableAttributedString(string: "Bài Đọc 1: ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
            attributedText.append(NSAttributedString(string: "\(firstReading)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]))
            
            self.contentTextView.attributedText = attributedText
        }

    }
    
}
