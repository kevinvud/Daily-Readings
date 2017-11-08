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

class ReadingsDisplayController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    var readingData: ReadingsContent?
    var checkCellAndTextColorValue = true
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    lazy var sectionTitle = [Section(sectionTitle: "Bài Đọc 1", sectionContent: (self.readingData?.reading1)!),  Section(sectionTitle: "Bài Đọc 2", sectionContent: (self.readingData?.reading2)!), Section(sectionTitle: "Phúc Âm", sectionContent: (self.readingData?.gospel)!)]
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let audioRightBarButton = UIButton(type: UIButtonType.system)
    
    var currentCellBackgroundColor = UIColor.rgb(red: 227, green: 224, blue: 222)
    var currentTextColorInCell = UIColor.black
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appdelegate.shouldSupportAllOrientation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        collectionView?.showsVerticalScrollIndicator = false
        navigationItem.title = readingData?.dateLabel
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Georgia", size: 16)!]
        collectionView?.backgroundColor = .white
        collectionView?.register(ReadingsDisplayCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        loadAudioUrl()
        setupNavItems()
       

    }
    
    func setupNavItems() {
    
        let leftBarButton = UIButton(type: .system)
        leftBarButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        leftBarButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        leftBarButton.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        
        audioRightBarButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.normal)
        audioRightBarButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        audioRightBarButton.addTarget(self, action: #selector(handlePlayAudio), for: .touchUpInside)
        
        let brighnessRightBarButton = UIButton(type: UIButtonType.system)
        brighnessRightBarButton.setImage(#imageLiteral(resourceName: "brightness").withRenderingMode(.alwaysOriginal), for: .normal)
        brighnessRightBarButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        brighnessRightBarButton.addTarget(self, action: #selector(handleBrightnessChanged), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: brighnessRightBarButton), UIBarButtonItem(customView: audioRightBarButton)]

    }
    
    func loadAudioUrl() {
        guard let audioUrl = readingData?.audioUrl else {return}
        guard let url = URL(string: audioUrl) else {return}
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
    
    @objc func handleBrightnessChanged () {
        
        let setFirstTimeButtonClickValueEqualsFalse = UserDefaults.standard.bool(forKey: "checkValue")        
        var cellBackgroundColorChanged: UIColor?
        var cellTextColorChanged: UIColor?
        
        if setFirstTimeButtonClickValueEqualsFalse == false {
            cellBackgroundColorChanged = UIColor.gray
            cellTextColorChanged = UIColor.white
            self.checkCellAndTextColorValue = true
            UserDefaults.standard.setColor(color: cellBackgroundColorChanged, forKey: "cellBackgroundColor")
            UserDefaults.standard.setColor(color: cellTextColorChanged, forKey: "textColor")
            UserDefaults.standard.set(self.checkCellAndTextColorValue, forKey: "checkValue")
            DispatchQueue.main.async {
                self.currentCellBackgroundColor = cellBackgroundColorChanged!
                self.currentTextColorInCell = cellTextColorChanged!
                self.collectionView?.reloadData()
            }
        }else{
            cellBackgroundColorChanged = UIColor.rgb(red: 227, green: 224, blue: 222)
            cellTextColorChanged = UIColor.black
            self.checkCellAndTextColorValue = false
            UserDefaults.standard.setColor(color: cellBackgroundColorChanged, forKey: "cellBackgroundColor")
            UserDefaults.standard.setColor(color: cellTextColorChanged, forKey: "textColor")
            UserDefaults.standard.set(checkCellAndTextColorValue, forKey: "checkValue")
            DispatchQueue.main.async {
                self.currentCellBackgroundColor = cellBackgroundColorChanged!
                self.currentTextColorInCell = cellTextColorChanged!
                self.collectionView?.reloadData()
                
            }
        }
    }
    
    @objc func handleGoBack() {
        appdelegate.shouldSupportAllOrientation = false
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handlePlayAudio() {
        
        if playerItem?.error != nil {
            handleNetworkErrorWhenPlayButtonClicked()
            loadAudioUrl()
            return
        }
        
        if player?.rate == 0 {
            audioRightBarButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
            player?.play()
    
        } else {
            audioRightBarButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
            player?.pause()
            
        }
    }
    
    func handleNetworkErrorWhenPlayButtonClicked() {
        
        let alert = UIAlertController(title: "Network Error", message: "Please check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ReadingsDisplayController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ReadingsDisplayCell{
            cell.cellContentLabel.text = sectionTitle[indexPath.section].sectionContent
            if let cellBgColor = UserDefaults.standard.colorForKey(key: "cellBackgroundColor") , let cellTextColor = UserDefaults.standard.colorForKey(key: "textColor"){
                cell.backgroundColor = cellBgColor
                cell.cellContentLabel.textColor = cellTextColor
                return cell
            } else{
                cell.backgroundColor = currentCellBackgroundColor
                cell.cellContentLabel.textColor = currentTextColorInCell
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = ReadingsDisplayCell(frame: frame)
        dummyCell.cellContentLabel.text = sectionTitle[indexPath.section].sectionContent
        dummyCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        return CGSize(width: view.frame.width, height: estimatedSize.height + 5)

        
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTitle.count
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderCell {
            let content = sectionTitle[indexPath.section]
            header.sectionTitle = content
             return header
        }
        return UICollectionReusableView()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}
