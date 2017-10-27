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
            self.contentLabel.text = readingData?.reading1
            if let dateLabel = readingData?.dateLabel{
                self.dateLabel.text = "\(dateLabel)"
            }
        }
    }
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
//        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        return label
    }()
    
    
    let contentLabel: UILabel = {
        let tf = UILabel()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.numberOfLines = 0
        return tf
    }()
    
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.gray
        return line
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func setupViews(){
        
        addSubview(imageView)
        addSubview(contentLabel)
        addSubview(dateLabel)
        addSubview(todayLabel)
        addSubview(lineSeparator)
        
        imageView.anchor(top: contentLabel.bottomAnchor, left: leftAnchor, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        todayLabel.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, bottom: contentLabel.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 20)
        
        dateLabel.anchor(top: topAnchor, left: leftAnchor, bottom: todayLabel.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 20)
        
        contentLabel.anchor(top: todayLabel.bottomAnchor, left: leftAnchor, bottom: imageView.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 100)
        
        lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 8)
        
    }
    
    private func setupImageView(){
        
        guard let imageViewUrl = readingData?.imageViewUrl else {return}
        guard let url = URL(string: imageViewUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch profile image:", error)
                return
            }
            
            guard let data = data else {return}
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            }.resume()
    }
    
    
}
