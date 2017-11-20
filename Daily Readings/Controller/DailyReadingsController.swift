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
    
    let screenSize: CGRect = UIScreen.main.bounds
    var currentDate = Date()
    var data = [ReadingsContent]()
    var activityIndicator = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
    var strLabel = UILabel()
//    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    let errorMessageLabel: UILabel  = {
        let label = UILabel()
        label.text = "Không thể kết nối tới Internet. Xin vui lòng kiểm tra đường truyền."
        label.font = UIFont.init(name: "Georgia", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if screenSize.width < 768 {
//            appdelegate.shouldSupportAllOrientation = false
//        } else{
//            appdelegate.shouldSupportAllOrientation = true
//        }
        let attrs = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Medium", size: 20)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.title = "Bài Đọc"
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkIfRefreshIsNeeded),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
//            if UIDeviceOrientationIsLandscape(UIDeviceOrientation.landscapeLeft) || UIDeviceOrientationIsLandscape(UIDeviceOrientation.landscapeRight){
//                let value = UIInterfaceOrientation.portrait.rawValue
//                UIDevice.current.setValue(value, forKey: "orientation")
//            }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        collectionView?.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        collectionView?.register(DailyReadingsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.alwaysBounceVertical = true
        checkInternetConnection()
        checkDate()
        
    }
    
    func checkInternetConnection() {
        if currentReachabilityStatus == .notReachable{
            DispatchQueue.main.async {
                self.errorMessageLabel.isHidden = false
                self.effectView.isHidden = true
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
    
    @objc func checkIfRefreshIsNeeded() {
        
        let dateCheck = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        let dateCheckAfterFormat = formatter.string(from: dateCheck)
        let currentDateAfterFormat = formatter.string(from: currentDate)
        
        if dateCheckAfterFormat != currentDateAfterFormat {
            handleRefresh()
            currentDate = dateCheck
        }
        
    }
    
//    func showActivityIndicator() {
//
//        strLabel.removeFromSuperview()
//        activityIndicator.removeFromSuperview()
//        effectView.removeFromSuperview()
//
//        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
//        strLabel.text = "Refreshing..."
//        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
//        strLabel.textColor = .black
//
//        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
//        effectView.layer.cornerRadius = 15
//        effectView.clipsToBounds = true
//
//        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
//        activityIndicator.startAnimating()
//
//        effectView.contentView.addSubview(activityIndicator)
//        effectView.contentView.addSubview(strLabel)
//        view.addSubview(effectView)
//
//    }
    
    func handleRefresh() {
        self.data.removeAll()
        self.checkDate()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    @objc func handleReloadCell() {
        DispatchQueue.main.async {
                self.collectionView?.reloadData()
        }
    }
    
    @objc func checkDate() {
//        showActivityIndicator()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        
        let VNDateFormatter = DateFormatter()
        VNDateFormatter.dateFormat = "EEEE, d MMMM, yyyy"
        VNDateFormatter.locale = Locale(identifier: "vi_VN")
        
        guard var tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date) else {return}
        
        guard let endDate = Calendar.current.date(byAdding: .day, value: -1, to: date) else {return}
        
       
        while tomorrow >= endDate {
            let tomorrowNow = formatter.string(from: tomorrow)
            let VNDateFormat = VNDateFormatter.string(from: tomorrow)
            
            var checkTodayOrTomorrowOrYesterdayLabel = ""
            
            if NSCalendar.current.isDateInTomorrow(tomorrow) {
                checkTodayOrTomorrowOrYesterdayLabel = "Bài Đọc Ngày Mai"
            } else if NSCalendar.current.isDateInToday(tomorrow) {
                checkTodayOrTomorrowOrYesterdayLabel = "Bài Đọc Hôm Nay"
            } else{
                checkTodayOrTomorrowOrYesterdayLabel = "Bài Đọc Hôm Qua"
            }

            Database.database().reference().child("Brain").child("Readings Data").child("Date").child(tomorrowNow).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else {return}
                self.errorMessageLabel.isHidden = true
                let readingContent = ReadingsContent(dictionary: dictionary, dateLabel: VNDateFormat, checkTodayOrTomorrowOrYesterdayLabel: checkTodayOrTomorrowOrYesterdayLabel)
                self.data.append(readingContent)
                self.data.sort(by: { (message1, message2) -> Bool in
                    return VNDateFormatter.date(from: message1.dateLabel)! > VNDateFormatter.date(from: message2.dateLabel)!
                })
                self.handleReloadCell()
                
            }, withCancel: nil)
            tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: tomorrow)!
        }
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.70, execute: {
//            self.activityIndicator.stopAnimating()
//            self.effectView.removeFromSuperview()
//
//        })
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DailyReadingsCell
            if data.count > 0 {
                cell.delegate = self
                cell.readingData = data[indexPath.item]
            } else{
                print("OUT OF BOUNCE IS HERE")
                cell.readingData = nil
            }

             return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = DummyCellForDailyReadingsHeight(frame: frame)
        dummyCell.cellContentLabel.text = "\(data[indexPath.item].dateLabel)\n \(String(describing: data[indexPath.item].todayMass))\n \(String(describing: data[indexPath.item].checkTodayOrTomorrowOrYesterdayLabel))\n"
        dummyCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        if (UIDevice.current.model == "iPhone"){
            return CGSize(width: view.frame.width, height: estimatedSize.height + 250 + 80 + 51 + 10)
        } else{
            return CGSize(width: view.frame.width, height: estimatedSize.height + 500 + 150 + 51 + 10)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let readingsData = data[indexPath.item]
        let readingsDisplayController = ReadingsDisplayController(collectionViewLayout: UICollectionViewFlowLayout())
        readingsDisplayController.readingData = readingsData
//        readingsDisplayController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(readingsDisplayController, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
}
extension DailyReadingsController: DailyReadingsCellDelegate{
    
    func handleSharePressed(image: UIImage, todayDate: String, todayMass: String) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let shareItems: Array = ["\(todayDate)\n\(todayMass)", image] as [Any]
        let activityController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityController.excludedActivityTypes = [UIActivityType.saveToCameraRoll, .assignToContact, .assignToContact, .openInIBooks]
        activityController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                //cancel sharing
                return
            }
            //completed
        }
        activityController.popoverPresentationController?.sourceView = self.view
        present(activityController, animated: true, completion: nil)
    }
}
