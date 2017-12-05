//
//  NewsFeedController.swift
//  Daily Readings
//
//  Created by PoGo on 11/7/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import SafariServices

private let reuseIdentifier = "Cell"
private let footerId = "footerId"

class RssCategoriesController: UICollectionViewController {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "newsCategoriesBackground")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundView = imageView
        let attrs = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.title = "Tin Công Giáo"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Trở Về", style: .plain, target: nil, action: nil)
        self.collectionView?.register(RssCategoriesCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(RssCategoriesFooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)

    }
    
}

extension RssCategoriesController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.getCategories().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RssCategoriesCell
        cell.rssCategories = DataService.instance.getCategories()[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let readingsData = DataService.instance.getCategories()[indexPath.item]
        let newsFeedController = NewsFeedController(collectionViewLayout: UICollectionViewFlowLayout())
        newsFeedController.data = readingsData
        navigationController?.pushViewController(newsFeedController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

         if (UIDevice.current.model == "iPhone") || (UIDevice.current.model == "iPod") {
            return CGSize(width: view.frame.width, height: 144)
        } else{
            return CGSize(width: view.frame.width, height: 360)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! RssCategoriesFooterCell
        return footer
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}
