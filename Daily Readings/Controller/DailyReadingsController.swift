//
//  DailyReadingsController.swift
//  Daily Readings
//
//  Created by PoGo on 10/26/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

private let cellId = "DailyCellId"

class DailyReadingsController: UICollectionViewController {
    
    var currentDate = Date()
    var data = [ReadingsContent]()
    
    var notificationTime = DateComponents()
    
    let errorMessageLabel: UILabel  = {
        let label = UILabel()
        label.text = "Không thể kết nối tới Internet. Xin vui lòng kiểm tra đường truyền hoặc tắt xong mở ứng dụng lại."
        label.font = UIFont.init(name: "Georgia", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
       let ai = UIActivityIndicatorView()
        ai.activityIndicatorViewStyle = .whiteLarge
        ai.color = .black
        ai.hidesWhenStopped = true
        return ai
    }()
    
    let activityIndicatorView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let loadingLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Đang tải dữ liệu..."
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.textColor = .black
        return lb
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkIfRefreshIsNeeded),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.contentView.addSubview(activityIndicator)
        activityIndicatorView.contentView.addSubview(loadingLabel)

        collectionView?.backgroundColor = UIColor.rgb(red: 234, green: 237, blue: 240)
        collectionView?.register(DailyReadingsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.alwaysBounceVertical = true
        let attrs = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.title = "Bài Đọc"
        
        checkInternetConnection()
        showActivityIndicatory()
        checkDate()
        showNotificaton()
        
    }
    
    
    func showNotificaton() {
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if (settings.authorizationStatus == .notDetermined || settings.authorizationStatus == .authorized) && DataService.instance.dateInfo.hour == nil
            {
                let todayDate = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, d MMMM yyyy"
                let todayDateFormat = formatter.string(from: todayDate)
                var todayMass: String?
                
                self.notificationTime.hour = 15
                self.notificationTime.minute = 56
                
                Database.database().reference().child("Brain").child("Readings Data").child("Date").child(todayDateFormat).observeSingleEvent(of: .value) { (snapshot) in
                    guard let dictionary = snapshot.value as? [String: Any] else {return}
                    todayMass = dictionary["todayMass"] as? String ?? "Vào ứng dụng để xem ngày lễ và bài đọc hôm nay"
                    guard let contentBody = todayMass else {return}

                    let newComps = DateComponents(calendar: .current, timeZone: .current, hour: self.notificationTime.hour, minute: self.notificationTime.minute)
                    let content = UNMutableNotificationContent()
                    content.title = "Ngày Lễ Hôm Nay"
                    content.body = contentBody
                    content.sound = UNNotificationSound.default()
                    
                    //                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: newComps, repeats: true)
                    let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request) { (error) in
                        if error != nil {
                            print(error ?? "Nothing")
                        }
                    }
                }
            }
        }
    }
    
    func showActivityIndicatory() {
        
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 280, height: 90)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        activityIndicator.anchor(top: nil, left: activityIndicatorView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 75, height: 75)
        
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorView.centerYAnchor).isActive = true
        
        loadingLabel.anchor(top: nil, left: activityIndicator.rightAnchor, bottom: nil, right: activityIndicatorView.rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 15, width: 0, height: 75)
         loadingLabel.centerYAnchor.constraint(equalTo: activityIndicatorView.centerYAnchor).isActive = true
        
        activityIndicatorView.effect = UIBlurEffect(style: .prominent)
        
        activityIndicator.startAnimating()
    }
    
    func checkInternetConnection() {
        if currentReachabilityStatus == .notReachable{
            DispatchQueue.main.async {
                self.activityIndicatorView.removeFromSuperview()
                self.activityIndicator.stopAnimating()
                self.errorMessageLabel.isHidden = false
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
        var todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        let VNDateFormatter = DateFormatter()
        VNDateFormatter.dateFormat = "d MMMM"
        VNDateFormatter.locale = Locale(identifier: "vi_VN")
        
        guard let yesterdayDate = Calendar.current.date(byAdding: .day, value: -2, to: todayDate) else {return}
        
        while todayDate > yesterdayDate {
            let todayDateFormat = formatter.string(from: todayDate)
            let VnTodayDateFormat = VNDateFormatter.string(from: todayDate)
            
            var checkTodayOrTomorrowOrYesterdayLabel = ""
            
            if NSCalendar.current.isDateInToday(todayDate) {
                checkTodayOrTomorrowOrYesterdayLabel = "Hôm Nay"
            } else if NSCalendar.current.isDateInYesterday(todayDate) {
                checkTodayOrTomorrowOrYesterdayLabel = "Hôm Qua"
            }
            Database.database().reference().child("Brain").child("Readings Data").child("Date").child(todayDateFormat).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else {return}
                self.errorMessageLabel.isHidden = true
                
                let readingContent = ReadingsContent(dictionary: dictionary, dateLabel: VnTodayDateFormat, checkTodayOrTomorrowOrYesterdayLabel: checkTodayOrTomorrowOrYesterdayLabel)
                self.data.append(readingContent)
                self.data.sort(by: { (message1, message2) -> Bool in
                    return VNDateFormatter.date(from: message1.dateLabel)! > VNDateFormatter.date(from: message2.dateLabel)!
                })
                self.handleReloadCell()
                DispatchQueue.main.async {
                    self.activityIndicatorView.removeFromSuperview()
                    self.activityIndicator.stopAnimating()
                }
                
            }, withCancel: nil)
            todayDate = Calendar.current.date(byAdding: .day, value: -1, to: todayDate)!
       
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DailyReadingsCell
        if data.count > 0 {
            cell.delegate = self
            cell.readingData = data[indexPath.item]
            if indexPath.item == 0 {
                cell.todayLabel.backgroundColor = UIColor.rgb(red: 218, green: 207, blue: 239)
                cell.todayLabel.textAlignment = .center
            }
        } else{
            print("OUT OF BOUNCE IS HERE")
            cell.readingData = nil
        }
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = DummyCellForDailyReadingsHeight(frame: frame)
        dummyCell.cellContentLabel.text = data[indexPath.item].todayMass
        dummyCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        if (UIDevice.current.model == "iPhone") || (UIDevice.current.model == "iPod") {
            return CGSize(width: view.frame.width, height: estimatedSize.height + 250 + 10 + 5 + 30 + 5 + 150 + 15 + 25 + 30)
        } else{
            return CGSize(width: view.frame.width, height: estimatedSize.height + 500 + 10 + 5 + 30 + 5 + 150 + 15 + 25 + 30)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let readingsData = data[indexPath.item]
        let readingsDisplayController = ReadingsDisplayController(collectionViewLayout: UICollectionViewFlowLayout())
        readingsDisplayController.readingData = readingsData
        navigationController?.pushViewController(readingsDisplayController, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
}
extension DailyReadingsController: DailyReadingsCellDelegate {
    
    func handleSharePressed(image: UIImage, todayDate: String, todayMass: String) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let shareItems: Array = ["\(todayDate)\n\(todayMass)\n\nhttps://itunes.apple.com/us/app/t%C3%ADn-thác/id1315378723?ls=1&mt=8"] as [Any]
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

