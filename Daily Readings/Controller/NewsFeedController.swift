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

class NewsFeedController: UICollectionViewController {
    
    let url = "http://www.vietcatholic.net/News/Home/Rss"
    var rssItems = [RSSItem]()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .gray
        self.collectionView!.register(NewsFeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fetchData()
    }
    func fetchData () {
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        let feedparser = XMLFeedParser()
        feedparser.parseFeed(url: url) { (rssItemsFromServer) in
            self.rssItems = rssItemsFromServer
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
       
    }
    
}

extension NewsFeedController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rssItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsFeedCell
        cell.item = nil
        cell.item = self.rssItems[indexPath.item]

          return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let videoUrl = URL(string: rssItems[indexPath.row].link) else {return}
        let safariVC = SFSafariViewController(url: videoUrl)
        present(safariVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = NewsFeedCell(frame: frame)
        
//        dummyCell.descriptionLabel.text = rssItems[indexPath.item].description + rssItems[indexPath.item].pubDate
        let attributedText = NSMutableAttributedString(string: rssItems[indexPath.item].title, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)])
        dummyCell.titleLabel.attributedText = attributedText
        
        let attributedText2 = NSMutableAttributedString(string: rssItems[indexPath.item].description, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)])
        dummyCell.descriptionLabel.attributedText = attributedText2
        
        let attributedText3 = NSMutableAttributedString(string: "\(rssItems[indexPath.item].pubDate)\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)])
        
        attributedText.append(NSAttributedString(string: "NOVEMBER 7, 2017", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]))
        dummyCell.dateLabel.attributedText = attributedText3
        
        dummyCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        return CGSize(width: view.frame.width, height: estimatedSize.height + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
