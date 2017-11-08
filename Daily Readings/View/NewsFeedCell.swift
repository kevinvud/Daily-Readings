//
//  NewsFeedCell.swift
//  Daily Readings
//
//  Created by PoGo on 11/7/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class NewsFeedCell: UICollectionViewCell {
    
    var item: RSSItem? {
        didSet{
            DispatchQueue.main.async {
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
        lb.font = UIFont(name: "Trebuchet MS", size: 30)
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        return lb
        
    }()
    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Malayalam Sangam MN", size: 20)
        return lb
        
    }()
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Malayalam Sangam MN", size: 20)
        return lb
    }()
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = .purple
        return line
        
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
        stackView.alignment = .fill
     
        addSubview(stackView)
        addSubview(lineSeparator)

        
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 3)
    }
    
    func setupLabelDisplayed(){
            guard let descriptionText = self.item?.description else {return}
            let attributedText = NSMutableAttributedString(string: descriptionText, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .light), NSAttributedStringKey.foregroundColor : UIColor.gray])
            self.descriptionLabel.attributedText = attributedText
        
    }
    
    func setupDateLabel() {
        
        guard let dateFromUrl = self.item?.pubDate else {return}
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withInternetDateTime
        guard let date = dateFormatter.date(from:dateFromUrl) else {return}
        
        let datetest = date.timeAgoDisplay()
        
        let attributedText = NSMutableAttributedString(string: "\(datetest)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .light)])
        self.dateLabel.attributedText = attributedText

        
    }
    
    
    
}
