//
//  DailyReadingsController.swift
//  Daily Readings
//
//  Created by PoGo on 10/26/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase

private let cellId = "DailyCellId"

class DailyReadingsController: UICollectionViewController {
    
    
    var data = [ReadingsContent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(DailyReadingsCell.self, forCellWithReuseIdentifier: cellId)
      
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        guard var tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date) else {return}
        
        guard let endDate = Calendar.current.date(byAdding: .day, value: -7, to: date) else {return}
   
        
        

            while tomorrow >= endDate {
                let tomorrowNow = formatter.string(from: tomorrow)
                Database.database().reference().child("Date").child(tomorrowNow).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    guard let dictionary = snapshot.value as? [String: Any] else {return}
                    let readingContent = ReadingsContent(dictionary: dictionary, dateLabel: tomorrowNow)
                    self.data.append(readingContent)
                    
                    self.data.sort(by: { (message1, message2) -> Bool in
                        return formatter.date(from: message1.dateLabel!)! > formatter.date(from: message2.dateLabel!)!
                    })
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                   
                }, withCancel: nil)
                
                tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: tomorrow)!
                
            }
        }
}

extension DailyReadingsController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? DailyReadingsCell{
            cell.readingData = data[indexPath.item]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
