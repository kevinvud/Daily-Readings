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
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    var textFontSize: CGFloat = 22
    var dateLabelFontSize: CGFloat = 26
    var todayMassFontSize: CGFloat = 24
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
                    if todayLabelCheck == "Bài Đọc Hôm Nay" {
                        self.todayLabel.text = todayLabelCheck
                        self.todayLabel.backgroundColor = UIColor.rgb(red: 218, green: 207, blue: 239)
                    }else {
                        self.todayLabel.backgroundColor = #colorLiteral(red: 0.4845477343, green: 0.8451561332, blue: 0.9963156581, alpha: 1)
                        self.todayLabel.text = todayLabelCheck
                    }
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
        label.font = UIFont(name: "Avenir Next", size: dateLabelFontSize)
        label.font = UIFont.boldSystemFont(ofSize: dateLabelFontSize)
        return label
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: UIFont.Weight.light)
        label.textColor = .black
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var todayMass: UILabel = {
        let tf = UILabel()
        tf.font = UIFont.systemFont(ofSize: textFontSize, weight: UIFont.Weight.medium)
        tf.textColor = .red
        tf.textAlignment = .center
        tf.numberOfLines = 0
        return tf
    }()
    
    let contentTextView: UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = false
        tf.isEditable = false
        tf.isUserInteractionEnabled = false
        tf.backgroundColor = #colorLiteral(red: 0.9842278361, green: 0.9843688607, blue: 0.9841969609, alpha: 1)
        tf.textContainerInset = UIEdgeInsets.zero
        tf.textContainer.lineFragmentPadding = 0
        return tf
    }()
    
    let lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.rgb(red: 140, green: 140, blue: 140)
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
        bt.setTitle("Share", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bt.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        bt.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        bt.setImage(#imageLiteral(resourceName: "sharePost").withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = UIColor.rgb(red: 143, green: 150, blue: 163)
        bt.imageView?.contentMode = .scaleAspectFill
        bt.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        
        return bt
    }()
    
//    let TitleOnImage: UILabel = {
//        let lb = UILabel()
//        lb.numberOfLines = 0
//        lb.text = "Thien Chua De Mat Coi Nguoi Hien Duc, Va Tai Nguoi Lang Nghe Tieng Ho Cau"
//        lb.textAlignment = .center
//        lb.textColor = .white
//        lb.font = UIFont.boldSystemFont(ofSize: 26)
//        lb.font = UIFont(name: "Georgia", size: 26)
//        return lb
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9842278361, green: 0.9843688607, blue: 0.9841969609, alpha: 1)
        setupViews()
        
    }
    
//    override func setNeedsLayout() {
//        self.testLabel.setGradientBackground(colorOne: #colorLiteral(red: 0.480712831, green: 0.6986023784, blue: 0.9545471072, alpha: 1), colorTwo: #colorLiteral(red: 0.4771781564, green: 0.7520635724, blue: 0.9557964206, alpha: 1))
//    }
//    override func layoutSubviews() {
//        self.testLabel.setGradientBackground(colorOne: #colorLiteral(red: 0.480712831, green: 0.6986023784, blue: 0.9545471072, alpha: 1), colorTwo: #colorLiteral(red: 0.4771781564, green: 0.7520635724, blue: 0.9557964206, alpha: 1))
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }

    func setupViews(){
        if UIDevice.current.model == "iPhone" || UIDevice.current.model == "iPod"{
            textFontSize = 18
            dateLabelFontSize = 22
            todayMassFontSize = 20
            contentTextViewHeight = 90
            imageViewHeight = 250
        }
        
        let stackView = UIStackView(arrangedSubviews: [dateLabel,todayLabel, todayMass, contentTextView, readMoreLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        
//        imageView.addSubview(TitleOnImage)
        addSubview(imageView)
        addSubview(stackView)
        addSubview(lineSeparator)
        addSubview(shareButton)

 

        if #available(iOS 11.0, *) {
            imageView.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: imageViewHeight)
            stackView.anchor(top: imageView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: shareButton.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 10, paddingRight: 15, width: 0, height: 0)
            contentTextView.heightAnchor.constraint(equalToConstant: contentTextViewHeight).isActive = true
            shareButton.anchor(top: nil, left: nil, bottom: lineSeparator.topAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 15, width: 80, height: 25)
            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        } else {
            imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: imageViewHeight)
            stackView.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: shareButton.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 10, paddingRight: 15, width: 0, height: 0)
            contentTextView.heightAnchor.constraint(equalToConstant: contentTextViewHeight).isActive = true
            shareButton.anchor(top: nil, left: nil, bottom: lineSeparator.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 15, width: 80, height: 25)
            lineSeparator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        }
//        dateLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 20)
//        todayLabel.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 20)
//        todayLabel.sizeToFit()
//        todayMass.anchor(top: todayLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
//        todayMass.sizeToFit()
//        contentTextView.anchor(top: todayMass.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: contentTextViewHeight)
//        readMoreLabel.anchor(top: contentTextView.bottomAnchor, left: leftAnchor, bottom: nil , right: rightAnchor, paddingTop: -12, paddingLeft: 15, paddingBottom: 10, paddingRight: 15, width: 0, height: 20)
      
        

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
