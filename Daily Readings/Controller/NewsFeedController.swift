//
//  NewsFeedController.swift
//  Daily Readings
//
//  Created by PoGo on 11/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import SafariServices

private let reuseIdentifier = "Cell"

class NewsFeedController: UICollectionViewController {
    
    var data: RssCategories?
    var rssItems = [RSSItem]()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let errorMessageLabel: UILabel  = {
        let label = UILabel()
        label.text = "lại."
        label.font = UIFont.init(name: "Georgia", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.rgb(red: 234, green: 237, blue: 240)
        let attrs = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.title = data?.title
        
        // Register cell classes
        self.collectionView!.register(NewsFeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        checkInternetConnection()
        fetchData()
    }
    
    func checkInternetConnection() {
        if currentReachabilityStatus == .notReachable{
            DispatchQueue.main.async {
                self.errorMessageLabel.isHidden = false
                self.activityIndicator.isHidden = true
                self.displayErrorMessage()
            }
            
        } else {
            self.errorMessageLabel.isHidden = true
        }
        
    }
    
    func displayErrorMessage() {
        view.addSubview(errorMessageLabel)
        errorMessageLabel.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: view.frame.width, height: 100)
        errorMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
        func fetchData () {
            guard let url = data?.urlLink else {return}
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
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: (rssItems[indexPath.item].link)) else {return}
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rssItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsFeedCell
        cell.item = rssItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
                let dummyCell = NewsFeedCell(frame: frame)
        
                let attributedText = NSMutableAttributedString(string: rssItems[indexPath.item].title, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25)])
                dummyCell.titleLabel.attributedText = attributedText
        
                let attributedText2 = NSMutableAttributedString(string: rssItems[indexPath.item].description, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)])
                dummyCell.descriptionLabel.attributedText = attributedText2
        
                let attributedText3 = NSMutableAttributedString(string: "\(rssItems[indexPath.item].pubDate)\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)])
                attributedText.append(NSAttributedString(string: "NOVEMBER 7, 2017", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)]))
                dummyCell.dateLabel.attributedText = attributedText3
        
                dummyCell.layoutIfNeeded()
                let targetSize = CGSize(width: view.frame.width, height: 1000)
                let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
                return CGSize(width: view.frame.width, height: estimatedSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }

}
