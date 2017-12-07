//
//  ReflectionVC.swift
//  Daily Readings
//
//  Created by PoGo on 12/6/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let footerId = "footer"

class ReflectionVC: UICollectionViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.rgb(red: 234, green: 237, blue: 240)
        let attrs = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.title = "Suy Niệm"
        collectionView?.showsVerticalScrollIndicator = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Trở Về", style: .plain, target: nil, action: nil)
        
        self.collectionView!.register(ReflectionCategoriesCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(ReflectionFooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)

    }
}

extension ReflectionVC: UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.getReflectionCategories().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReflectionCategoriesCell
        cell.rssReflectionCategories = DataService.instance.getReflectionCategories()[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 232)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reflectionData = DataService.instance.getReflectionCategories()[indexPath.item]
        let reflectionFeedsController = ReflectionFeedsController(collectionViewLayout: UICollectionViewFlowLayout())
        reflectionFeedsController.data = reflectionData
        navigationController?.pushViewController(reflectionFeedsController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! ReflectionFooterCell
        return footer
    }
    
    
    
    
}
