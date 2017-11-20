//
//  SettingsMenuLauncherInReadingsVC.swift
//  Daily Readings
//
//  Created by PoGo on 11/19/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit


class SettingsMenuLauncherInReadingsVC: NSObject {
    
    let colorMenuId = "colorMenuCell"
    let fontSizeMenuId = "fontSizeMenuCell"
    
    let view = UIView()
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.layer.cornerRadius = 10
        return cv

    }()
    
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(colorMenuCell.self, forCellWithReuseIdentifier: colorMenuId)
        collectionView.register(fontSizeMenuCell.self, forCellWithReuseIdentifier: fontSizeMenuId)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in Daily cell")
    }
    
    func showSettings(navBarHeight: CGFloat, statusHeight: CGFloat) {
        
        let navBarHeight = navBarHeight
        let statusBarHeight = statusHeight

        if let window = UIApplication.shared.keyWindow {
//            let height: CGFloat = 200
//
//            let y = window.frame.height - height
            
            view.backgroundColor = UIColor.clear
            window.addSubview(view)
            window.addSubview(collectionView)
            
            

            collectionView.anchor(top: window.topAnchor, left: nil, bottom: nil, right: window.rightAnchor, paddingTop: statusBarHeight + navBarHeight + 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 0, height: 210)
            collectionView.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 2/3).isActive = true
            
//            collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            view.frame = window.frame
            
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
        }
        
        
        
    }
    
    @objc func handleDismiss() {
        print("DISMISS")
        self.view.alpha = 0
        
        if let window = UIApplication.shared.keyWindow {
            self.collectionView.isHidden = true
        
//            self.collectionView.anchor(top: <#T##NSLayoutYAxisAnchor?#>, left: <#T##NSLayoutXAxisAnchor?#>, bottom: <#T##NSLayoutYAxisAnchor?#>, right: <#T##NSLayoutXAxisAnchor?#>, paddingTop: <#T##CGFloat#>, paddingLeft: <#T##CGFloat#>, paddingBottom: <#T##CGFloat#>, paddingRight: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        }
        
        
    }

}

extension SettingsMenuLauncherInReadingsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fontSizeMenuId, for: indexPath) as! fontSizeMenuCell
            return cell
        }
        else if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colorMenuId, for: indexPath) as! colorMenuCell
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
}
