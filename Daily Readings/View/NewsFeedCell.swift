//
//  NewsFeedCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/7/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class NewsFeedCell: UICollectionViewCell {
    
    var imageUrl: String?
    var descriptionString: String?
    
    var item: RSSItem? {
        didSet{
                self.separatedString()
            
                DispatchQueue.main.async {
//                print(self.item?.description)
                    if let imageViewUrl = self.imageUrl{
                        self.imageView.loadImagesUsingCacheWithUrlString(imageViewUrl)
                    }
                self.titleLabel.text = self.item?.title
//                self.descriptionLabel.text = self.item?.description
                self.setupDateLabel()
//                self.dateLabel.text = self.item?.pubDate
                self.setupLabelDisplayed()
            }
            
         
        }
        
    }
    let titleLabel: UILabel = {
        
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Helvetica", size: 25)
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        return lb
        
    }()
    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Iowan", size: 17)
        return lb
        
    }()
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Athelas", size: 14)
        return lb
    }()
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.rgb(red: 190, green: 190, blue: 190)
        return line
        
    }()
    
    let imageView: CustomImageVIew = {
        let iv = CustomImageVIew()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews() {
        
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,descriptionLabel,dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
//        addSubview(imageView)
        addSubview(stackView)
        addSubview(lineSeparator)

//        imageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
//        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
    }
    
    func setupLabelDisplayed(){
            guard let descriptionText = self.descriptionString else {return}
        let attributedText = NSMutableAttributedString(string: descriptionText, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 140, green: 140, blue: 140)])
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
        let attributedText = NSMutableAttributedString(string: "\(datetest)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .light)])
        self.dateLabel.attributedText = attributedText

        
    }
    
    
    
}
