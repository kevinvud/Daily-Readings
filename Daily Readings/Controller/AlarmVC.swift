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
    
    var toggleValue = true
    
    
    let toggleLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.text = "Bật/Tắt thông báo hằng ngày"
        lb.font = UIFont(name: "AvenirNext-Regular", size: 18)
        return lb
    }()
    
    lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(handleToggle), for: .valueChanged)
        return toggle
    }()
    
    var showUserNotificationStateLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.text = "Xin vui lòng chọn giờ thông báo bên dưới"
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
        image.image = #imageLiteral(resourceName: "bg7")
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
        view.addSubview(imageView)
        view.addSubview(toggleLabel)
        view.addSubview(toggleSwitch)
        view.addSubview(showUserNotificationStateLabel)
        view.addSubview(showTimeLabel)
        view.addSubview(timePickerView)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let attrs = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.title = "Thông Báo"
        
        if let checkedTimePickerDisplay = UserDefaults.standard.value(forKey: "timeSaved") {
            timePickerView.setDate(checkedTimePickerDisplay as! Date, animated: false)
        }
        
        if let showTimeLabelFromUserDefaults = UserDefaults.standard.value(forKey: "showTimeLabel") {
            self.showTime = showTimeLabelFromUserDefaults as? String
            showUserNotificationStateLabel.text = "Thông báo sẽ hiện ra hằng ngày vào"
            showTimeLabel.text = showTime
        }
        
        if #available(iOS 11.0, *) {
            
            imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            toggleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 30)
            toggleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            toggleSwitch.anchor(top: toggleLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 20)
            toggleSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            showUserNotificationStateLabel.anchor(top: toggleSwitch.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 30)
            showUserNotificationStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            showTimeLabel.anchor(top: showUserNotificationStateLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 40)
            showTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            timePickerView.anchor(top: showTimeLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        } else {
            imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            toggleLabel.anchor(top: topLayoutGuide.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 30)
            toggleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            toggleSwitch.anchor(top: toggleLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 20)
            toggleSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            showUserNotificationStateLabel.anchor(top: toggleSwitch.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 30)
            showUserNotificationStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            showTimeLabel.anchor(top: showUserNotificationStateLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 40)
            showTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            timePickerView.anchor(top: showTimeLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        }
        checkNotificationAuthorization()
    }
    
    func checkNotificationAuthorization(){
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                if let toggleValueFromUserDefaults = UserDefaults.standard.object(forKey: "switchState") as? Bool {
                    self.toggleValue = toggleValueFromUserDefaults
                }
                DispatchQueue.main.async {
                    self.toggleSwitch.isOn = self.toggleValue
                    if self.toggleSwitch.isOn{
                        self.showTimeLabel.isHidden = false
                        self.timePickerView.isHidden = false
                        self.showUserNotificationStateLabel.isHidden = false
                    }else{
                        self.showTimeLabel.isHidden = true
                        self.timePickerView.isHidden = true
                        self.showUserNotificationStateLabel.isHidden = true
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    }
                }
            }
                
            else{
                DispatchQueue.main.async {
                self.toggleSwitch.isOn = self.toggleValue
                }
                let alertController = UIAlertController(title: "Xin vui lòng bật Notifications!", message: "Để nhận thông báo hằng ngày, bạn phải vào mục Notifications và bật \"Allow Notifications\" lên.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Để Sau", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    self.navigationController?.popViewController(animated: true)
                }
                let okAction = UIAlertAction(title: "Vào đây để bật Notifications", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
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
    
    @objc func handleToggle() {
        UserDefaults.standard.set(toggleSwitch.isOn, forKey: "switchState")
        if UserDefaults.standard.bool(forKey: "switchState") {
            DispatchQueue.main.async {
                self.showTimeLabel.isHidden = false
                self.timePickerView.isHidden = false
                self.showUserNotificationStateLabel.isHidden = false
                self.showUserNotificationStateLabel.text = "Xin vui lòng chọn giờ thông báo bên dưới"
                self.showTime = nil
                self.showTimeLabel.text = nil
                UserDefaults.standard.set(self.showTime, forKey: "showTimeLabel")
            }
        }else{
            DispatchQueue.main.async {
                self.showTimeLabel.isHidden = true
                self.timePickerView.isHidden = true
                self.showUserNotificationStateLabel.isHidden = true
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
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
        showUserNotificationStateLabel.text = "Thông báo sẽ hiện ra hằng ngày vào"
        DataService.instance.getTime(hour: timeFormatter.hour!, minute: timeFormatter.minute!, isScheduled: true)
        
        
        var fireTime = DateComponents()
        fireTime.hour = hours
        fireTime.minute = minutes
        let content = UNMutableNotificationContent()
        content.body = "⛪ Xin đừng quên vào ứng dụng này mỗi ngày, nó sẽ giúp bạn yêu Chúa hơn đấy! ⛪"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireTime, repeats: true)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print(error ?? "Notification Add Request Error")
            }
        }
        
        
    }
}
