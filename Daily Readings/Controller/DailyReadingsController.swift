//
//  DailyReadingsController.swift
//  Daily Readings
//
//  Created by PoGo on 10/26/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds
import UserNotifications

private let cellId = "DailyCellId"

var firstTimeLogin = UserDefaults.standard.bool(forKey: "launchedBefore")

class DailyReadingsController: UICollectionViewController, GADInterstitialDelegate {
    
    var currentDate = Date()
    var data = [ReadingsContent]()
    var interstitial: GADInterstitial?
    
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
        displayLoadingMessage()
        setupCollectionLookAndNavigation()
        checkInternetConnection()
        showActivityIndicatory()
        fetchDataFromServer()
        showNotificaton()
        checkFirstTimeLoginForAds_RunAds()
    }
    
    func displayLoadingMessage(){
        view.addSubview(activityIndicatorView)
        activityIndicatorView.contentView.addSubview(activityIndicator)
        activityIndicatorView.contentView.addSubview(loadingLabel)
    }
    
    func setupCollectionLookAndNavigation(){
        collectionView?.backgroundColor = UIColor.rgb(red: 234, green: 237, blue: 240)
        collectionView?.register(DailyReadingsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.alwaysBounceVertical = true
        let attrs = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.title = "Bài Đọc"
    }
    
    func checkFirstTimeLoginForAds_RunAds(){
        if firstTimeLogin {
            print("Not first launch.")
            interstitial = DataService.instance.createAndLoadInterstitial()
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    func showNotificaton() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if (settings.authorizationStatus == .notDetermined || settings.authorizationStatus == .authorized) && DataService.instance.checkScheduled() == false
            {
                var fireTime = DateComponents()
                fireTime.hour = 12
                fireTime.minute = 30
                let content = UNMutableNotificationContent()
                content.body = "⛪ Xin đừng quên vào ứng dụng này mỗi ngày, nó sẽ giúp bạn yêu Chúa hơn đấy! ⛪"
                content.sound = UNNotificationSound.default()
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: fireTime, repeats: true)
                let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { (error) in
                    if error != nil {
                        print(error ?? "Nothing")
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
        self.fetchDataFromServer()
    }
    
    func fetchDataFromServer() {
        let myGroup = DispatchGroup()
        var todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        let VNDateFormatter = DateFormatter()
        VNDateFormatter.dateFormat = "d MMMM yyyy"
        VNDateFormatter.locale = Locale(identifier: "vi_VN")
        
        guard let yesterdayDate = Calendar.current.date(byAdding: .day, value: -8, to: todayDate) else {return}
        
        while todayDate > yesterdayDate {
            myGroup.enter()
            let todayDateFormat = formatter.string(from: todayDate)
            let VnTodayDateFormat = VNDateFormatter.string(from: todayDate)
            
            var checkTodayOrTomorrowOrYesterdayLabel = ""
            
            if NSCalendar.current.isDateInToday(todayDate) {
                checkTodayOrTomorrowOrYesterdayLabel = "Hôm Nay"
            } else if NSCalendar.current.isDateInYesterday(todayDate) {
                checkTodayOrTomorrowOrYesterdayLabel = "Hôm Qua"
            }else{
                checkTodayOrTomorrowOrYesterdayLabel = "Tuần Trước"
            }
            Database.database().reference().child("Brain").child("Readings Data").child("Date").child(todayDateFormat).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else { myGroup.leave()
                    return}
                
                self.errorMessageLabel.isHidden = true
                let readingContent = ReadingsContent(dictionary: dictionary, dateLabel: VnTodayDateFormat, checkTodayOrTomorrowOrYesterdayLabel: checkTodayOrTomorrowOrYesterdayLabel)
                self.data.append(readingContent)
                myGroup.leave()
            }, withCancel: nil)
            todayDate = Calendar.current.date(byAdding: .day, value: -1, to: todayDate)!
        }
        myGroup.notify(queue: .main) {
            self.data.sort(by: { (message1, message2) -> Bool in
                return VNDateFormatter.date(from: message1.dateLabel)! > VNDateFormatter.date(from: message2.dateLabel)!
            })
            self.collectionView?.reloadData()
            self.activityIndicatorView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
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
            return CGSize(width: view.frame.width, height: estimatedSize.height + 250 + 10 + 10 + 30 + 10 + 150 + 10 + 25 + 15)
        } else{
            return CGSize(width: view.frame.width, height: estimatedSize.height + 512 + 10 + 10 + 30 + 10 + 288 + 10 + 25 + 25)
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
        guard (interstitial?.isReady) != nil else {return}
        self.interstitial?.present(fromRootViewController: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
        }, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
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

