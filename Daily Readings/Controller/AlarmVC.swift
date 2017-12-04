//
//  AlarmVC.swift
//  Daily Readings
//
//  Created by PoGo on 12/2/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase


class AlarmVC: UIViewController {
    
    
    var dailyReadingVC: DailyReadingsController?
    
    var todayMassInAlarmVC: String?
    
    var timeAfterUpdated: Date?
    
    var showTime: String?
    
    var timePickerDisplay: Date?
    
    let label: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.text = "Hiển thị thông báo lễ hằng ngày vào lúc:"
        lb.font = UIFont(name: "AvenirNext-Regular", size: 18)
        return lb
    }()
    
    lazy var showTimeLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.text = "\(showTime ?? "")"
        lb.font = UIFont(name: "BanglaSangamMN-Bold", size: 24)
        return lb
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bg3")
        return image
        
    }()
    
    lazy var timePickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.addTarget(self, action: #selector(getTime), for: .valueChanged)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checkedTimePickerDisplay = UserDefaults.standard.value(forKey: "timeSaved") {
            timePickerView.setDate(checkedTimePickerDisplay as! Date, animated: false)
        }
        
        view.backgroundColor = .gray
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(showTimeLabel)
        view.addSubview(timePickerView)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let attrs = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.title = "Thông Báo Lễ"
        
        if let showTimeLabelFromUserDefaults = UserDefaults.standard.value(forKey: "showTimeLabel") {
            self.showTime = showTimeLabelFromUserDefaults as? String
            showTimeLabel.text = showTime
        }
        
        if #available(iOS 11.0, *) {
            imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            label.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 40)
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            showTimeLabel.anchor(top: label.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 50)
            showTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            timePickerView.anchor(top: showTimeLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        } else {
            imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            label.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 40)
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            showTimeLabel.anchor(top: label.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 50)
            showTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            timePickerView.anchor(top: showTimeLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        }
        
        
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if(settings.authorizationStatus == .authorized)
            {
                //Notification is enabled
            }
            else
            {
                let alertController = UIAlertController(title: "Xin vui lòng bật Notifications!", message: "Để nhận thông báo hằng ngày, bạn phải vào mục Notifications và bật  \"Allow Notifications\" lên.", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction = UIAlertAction(title: "Để Sau", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    self.navigationController?.popViewController(animated: true)
                }
                let okAction = UIAlertAction(title: "Vào Đây Để Bật Notifications", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    DispatchQueue.main.async {
                        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                print("Settings opened: \(success)")
                            })
                        }
                    }
                }
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func getTime(){
        
        let timeFormatter = Calendar.current.dateComponents(in: .current, from: timePickerView.date)
        timePickerDisplay = timePickerView.date
        UserDefaults.standard.set(timePickerDisplay, forKey: "timeSaved")
        let hours = timeFormatter.hour!
        let minutes = timeFormatter.minute!
        
        if minutes < 10 {
            showTime = "\(hours) giờ 0\(minutes) phút"
            UserDefaults.standard.set(showTime, forKey: "showTimeLabel")
        }else{
            showTime = "\(hours) giờ \(minutes) phút"
            UserDefaults.standard.set(showTime, forKey: "showTimeLabel")
        }
        showTimeLabel.text = showTime
        
        DataService.instance.getTime(hour: timeFormatter.hour!, minute: timeFormatter.minute!)
        DataService.instance.dateInfo.hour = timeFormatter.hour
        DataService.instance.dateInfo.minute = timeFormatter.minute
        
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        let todayDateFormat = formatter.string(from: todayDate)
        var todayMass: String?
        
        Database.database().reference().child("Brain").child("Readings Data").child("Date").child(todayDateFormat).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            todayMass = dictionary["todayMass"] as? String ?? "Vào ứng dụng để xem ngày lễ và bài đọc hôm nay"
            guard let contentBody = todayMass else {return}
            
            let newComps = DateComponents(calendar: .current, timeZone: .current, hour: hours, minute: minutes)
            print(newComps)
            let content = UNMutableNotificationContent()
            content.title = "Ngày Lễ Hôm Nay"
            content.body = contentBody
            content.sound = UNNotificationSound.default()
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComps, repeats: true)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if error != nil {
                    print(error ?? "Notification Add Request Error")
                }
            }
        }
        
    }
}
