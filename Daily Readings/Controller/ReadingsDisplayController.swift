//
//  ReadingsDisplayController.swift
//  Daily Readings
//
//  Created by PoGo on 11/1/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import AVFoundation



private let reuseIdentifier = "Cell"
private let headerId = "headerId"

class ReadingsDisplayController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{
    
    var readingCellTextSize: CGFloat?
    var readingCellTitleSize: CGFloat?
    var readingData: ReadingsContent?
    var checkCellAndTextColorValue = true
    var checkFontSizeValue = true
    //    var sectionData: Section?
    ////    var player: AVPlayer?
    ////    var playerItem: AVPlayerItem?
    //    lazy var sectionTitle = [Section(sectionTitle: "Bài Đọc 1", sectionContent: (self.readingData?.reading1)!),
    //                             Section(sectionTitle: "Bài Đọc 2", sectionContent: (self.readingData?.reading2)!),
    //                             Section(sectionTitle: "Phúc Âm", sectionContent: (self.readingData?.gospel)!)]
    //    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    //    let audioRightBarButton = UIButton(type: UIButtonType.system)
    
    var readingCellBackgroundColor: UIColor?
    var readingCellTextColor: UIColor?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        let attrs = [
        //            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Medium", size: 20)!
        //        ]
        //        navigationController?.navigationBar.titleTextAttributes = attrs
        //        navigationItem.title = readingData?.dateLabel
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let textSizeValue = UserDefaults.standard.value(forKey: "textSizeValueChanged"), let titleSizeValue = UserDefaults.standard.value(forKey: "titleSizeValueChanged") {
            readingCellTextSize = textSizeValue as? CGFloat
            readingCellTitleSize = titleSizeValue as? CGFloat
        } else{
            readingCellTextSize = 20
            readingCellTitleSize = 25
        }
        
        if let readingCellBackgroundValue = UserDefaults.standard.colorForKey(key: "cellBackgroundColor"), let readingCellTextColorValue = UserDefaults.standard.colorForKey(key: "textColor"){
            readingCellBackgroundColor = readingCellBackgroundValue
            readingCellTextColor = readingCellTextColorValue
        }else{
            readingCellBackgroundColor = #colorLiteral(red: 0.9923532605, green: 0.9864496589, blue: 0.9830352664, alpha: 1)
            readingCellTextColor = UIColor.black
        }
        
        // enable swipe back
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        //
        
        collectionView?.showsVerticalScrollIndicator = true
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 29, height: 29))
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(named: "readingVCNavImage")
        imageView.image = image
        navigationItem.titleView = imageView
        collectionView?.backgroundColor = UIColor.rgb(red: 234, green: 237, blue: 240)
        collectionView?.register(ReadingsDisplayCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupNavItems()
    }
    
    func setupNavItems() {
        
        let leftBarButton = UIButton(type: .system)
        leftBarButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        leftBarButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        leftBarButton.tintColor = UIColor.rgb(red: 59, green: 104, blue: 198)
        leftBarButton.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        
        
        let brighnessRightBarButton = UIButton(type: UIButtonType.system)
        brighnessRightBarButton.setImage(#imageLiteral(resourceName: "brightness").withRenderingMode(.alwaysTemplate), for: .normal)
        brighnessRightBarButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        brighnessRightBarButton.tintColor = UIColor.rgb(red: 59, green: 104, blue: 198)
        brighnessRightBarButton.addTarget(self, action: #selector(handleBrightnessChanged), for: .touchUpInside)
        
        let resizeIcon = UIButton(type: UIButtonType.system)
        resizeIcon.setImage(#imageLiteral(resourceName: "resizeIcon").withRenderingMode(.alwaysTemplate), for: .normal)
        resizeIcon.tintColor = UIColor.rgb(red: 59, green: 104, blue: 198)
        resizeIcon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        resizeIcon.addTarget(self, action: #selector(changeFontSize), for: .touchUpInside)
        
        //        navigationItem.rightBarButtonItem = [UIBarButtonItem(customView: brighnessRightBarButton)]
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: brighnessRightBarButton), UIBarButtonItem(customView: resizeIcon)]
    }
    
    @objc func changeFontSize() {
        
        let setFirstTimeFontButtonClickValueEqualsToFalse = UserDefaults.standard.bool(forKey: "checkFontValue")
        
        if setFirstTimeFontButtonClickValueEqualsToFalse == false {
            self.readingCellTextSize = 30
            self.readingCellTitleSize = 35
            self.checkFontSizeValue = true
            UserDefaults.standard.set(readingCellTextSize, forKey: "textSizeValueChanged")
            UserDefaults.standard.set(readingCellTitleSize, forKey: "titleSizeValueChanged")
            UserDefaults.standard.set(self.checkFontSizeValue, forKey: "checkFontValue")
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }else{
            self.readingCellTextSize = 20
            self.readingCellTitleSize = 25
            self.checkFontSizeValue = false
            UserDefaults.standard.set(readingCellTextSize, forKey: "textSizeValueChanged")
            UserDefaults.standard.set(readingCellTitleSize, forKey: "titleSizeValueChanged")
            UserDefaults.standard.set(self.checkFontSizeValue, forKey: "checkFontValue")
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                
            }
        }
        
    }
    
    //    @objc func handleMenuButton() {
    //
    //        let statusHeight = UIApplication.shared.statusBarFrame.size.height
    ////        guard let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.intrinsicContentSize.height else {return}
    //        guard let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.frame.height else {return}
    //        settingsMenuLauncherInReadingsVC.showSettings(navBarHeight: navigationBarHeight, statusHeight: statusHeight)
    //
    //    }
    
    //    func loadAudioUrl() {
    //        guard let audioUrl = readingData?.audioUrl else {return}
    //        guard let url = URL(string: audioUrl) else {return}
    //        playerItem = AVPlayerItem(url: url)
    //        player = AVPlayer(playerItem: playerItem)
    //    }
    
    @objc func handleBrightnessChanged () {
        
        let setFirstTimeButtonClickValueEqualsFalse = UserDefaults.standard.bool(forKey: "checkValue")
        
        if setFirstTimeButtonClickValueEqualsFalse == false {
            readingCellBackgroundColor = UIColor.init(white: 0.2, alpha: 0.8)
            readingCellTextColor = UIColor.white
            self.checkCellAndTextColorValue = true
            UserDefaults.standard.setColor(color: readingCellBackgroundColor, forKey: "cellBackgroundColor")
            UserDefaults.standard.setColor(color: readingCellTextColor, forKey: "textColor")
            UserDefaults.standard.set(self.checkCellAndTextColorValue, forKey: "checkValue")
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }else{
            readingCellBackgroundColor = #colorLiteral(red: 0.9842278361, green: 0.9843688607, blue: 0.9841969609, alpha: 1)
            readingCellTextColor = UIColor.black
            self.checkCellAndTextColorValue = false
            UserDefaults.standard.setColor(color: readingCellBackgroundColor, forKey: "cellBackgroundColor")
            UserDefaults.standard.setColor(color: readingCellTextColor, forKey: "textColor")
            UserDefaults.standard.set(checkCellAndTextColorValue, forKey: "checkValue")
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                
            }
        }
    }
    
    
    @objc func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    //    @objc func handlePlayAudio() {
    //
    //        if playerItem?.error != nil {
    //            handleNetworkErrorWhenPlayButtonClicked()
    //            loadAudioUrl()
    //            return
    //        }
    //
    //        if player?.rate == 0 {
    //            audioRightBarButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
    //            player?.play()
    //
    //        } else {
    //            audioRightBarButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
    //            player?.pause()
    //
    //        }
    //    }
    
    //    func handleNetworkErrorWhenPlayButtonClicked() {
    //
    //        let alert = UIAlertController(title: "Network Error", message: "Please check your internet connection", preferredStyle: .alert)
    //        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (action) in
    //            alert.dismiss(animated: true, completion: nil)
    //        }))
    //        self.present(alert, animated: true, completion: nil)
    //    }
}

extension ReadingsDisplayController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReadingsDisplayCell
        
        if indexPath.item == 0 {
            cell.titleLabel.text = "Bài Đọc 1"
            cell.titleLabel.font = UIFont(name: "AvenirNext-Bold", size: readingCellTitleSize!)
            cell.titleLabel.textColor = readingCellTextColor
            cell.backgroundColor = readingCellBackgroundColor
            cell.cellContentLabel.textColor = readingCellTextColor
            cell.cellContentLabel.font = UIFont(name: "Avenir Next", size: readingCellTextSize!)
            cell.cellContentLabel.text = readingData?.reading1
            return cell
        }
        else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReadingsDisplayCell
            cell.titleLabel.text = "Bài Đọc 2"
            cell.titleLabel.font = UIFont(name: "AvenirNext-Bold", size: readingCellTitleSize!)
            cell.titleLabel.textColor = readingCellTextColor
            cell.backgroundColor = readingCellBackgroundColor
            cell.cellContentLabel.textColor = readingCellTextColor
            cell.cellContentLabel.font = UIFont(name: "Avenir Next", size: readingCellTextSize!)
            cell.cellContentLabel.text = readingData?.reading2
            return cell
        }
            
        else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReadingsDisplayCell
            cell.titleLabel.text = "Phúc Âm"
            cell.titleLabel.textColor = readingCellTextColor
            cell.titleLabel.font = UIFont(name: "AvenirNext-Bold", size: readingCellTitleSize!)
            cell.backgroundColor = readingCellBackgroundColor
            cell.cellContentLabel.textColor = readingCellTextColor
            cell.cellContentLabel.font = UIFont(name: "Avenir Next", size: readingCellTextSize!)
            cell.cellContentLabel.text = readingData?.gospel
            return cell
        }
        
        return UICollectionViewCell()
        //        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ReadingsDisplayCell{
        
        ////            cell.cellContentLabel.text = sectionTitle[indexPath.section].sectionContent
        //            cell.cellContentLabel.font = UIFont(name: "Avenir Next", size: textSize)
        //            if let cellBgColor = UserDefaults.standard.colorForKey(key: "cellBackgroundColor") , let cellTextColor = UserDefaults.standard.colorForKey(key: "textColor"){
        //                cell.backgroundColor = cellBgColor
        //                cell.cellContentLabel.textColor = cellTextColor
        //                return cell
        //            } else{
        //                cell.backgroundColor = currentCellBackgroundColor
        //                cell.cellContentLabel.textColor = currentTextColorInCell
        //                return cell
        //            }
        //
        //        }
        //
        //        return UICollectionViewCell()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 120)
        let dummyCell = ReadingsDisplayCell(frame: frame)
        dummyCell.cellContentLabel.font = UIFont(name: "Avenir Next", size: readingCellTextSize!)
        
        //        dummyCell.cellContentLabel.text = sectionTitle[indexPath.section].sectionContent
        
        if indexPath.item == 0{
            dummyCell.cellContentLabel.text = "\(readingData?.reading1 ?? " ")\n\n"
            dummyCell.layoutIfNeeded()
            let targetSize = CGSize(width: view.frame.width, height: 2000)
            let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
            return CGSize(width: view.frame.width, height: estimatedSize.height + 40 + 15 + 15 + 5)
            
        } else if indexPath.item == 1 {
            guard let reading2Count = readingData?.reading2?.count else {return CGSize(width: 50, height: 50)}
            if reading2Count < 5 {
                return CGSize(width: view.frame.width, height: 80)
            }else{
                dummyCell.cellContentLabel.text = "\(readingData?.reading2 ?? " ")\n\n"
                dummyCell.layoutIfNeeded()
                let targetSize = CGSize(width: view.frame.width, height: 2000)
                let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
                return CGSize(width: view.frame.width, height: estimatedSize.height + 40 + 15 + 15 + 5)
            }
            
        } else if indexPath.item == 2 {
            dummyCell.cellContentLabel.text = "\(readingData?.gospel ?? " ")\n\n"
            dummyCell.layoutIfNeeded()
            let targetSize = CGSize(width: view.frame.width, height: 2000)
            let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
            return CGSize(width: view.frame.width, height: estimatedSize.height + 40 + 15 + 15 + 5)
        }
        
        return CGSize(width: 100, height: 100)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

