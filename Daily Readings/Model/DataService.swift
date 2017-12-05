//
//  DataService.swift
//  Daily Readings
//
//  Created by PoGo on 11/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class DataService {
    
    static let instance = DataService()
    
    var dateInfo = DateComponents()
    
    var notificationIsScheduled = false
    
    
    let rssCategories = [RssCategories(title: "Tin Giáo Hội Việt Nam", urlLink: "http://baoconggiao.net/index.php/rss/tin-giao-hoi-viet-nam/", imageName: "vietnam"),
                         RssCategories(title: "Tin Vatican", urlLink: "http://baoconggiao.net/index.php/rss/tin-vatican/", imageName: "vatican"),
                         RssCategories(title: "Tin Công Giáo Thế Giới", urlLink: "http://baoconggiao.net/index.php/rss/tin-cong-giao-the-gioi/", imageName: "general"),
                         RssCategories(title: "Tin Giáo Xứ - Hội Đoàn", urlLink: "http://baoconggiao.net/index.php/rss/tin-giao-xu-hoi-doan/", imageName: "local"),
                         RssCategories(title: "Tin Bác Ái", urlLink: "http://baoconggiao.net/index.php/rss/bac-ai/", imageName: "charity")
                         ]
    
    let moreMenuItem = [MoreMenuItem(title: "Đánh Giá Ứng Dụng", imageName: "rate"),
                        MoreMenuItem(title: "Theo dõi trên trang Facebook", imageName: "followFacebook"),
                        MoreMenuItem(title: "Chia Sẻ", imageName: "share"),
                        MoreMenuItem(title: "Chỉnh Giờ Hiện Thông Báo Hằng Ngày", imageName: "alarm"),
                        MoreMenuItem(title: "Đóng Góp", imageName: "donate"),
                        MoreMenuItem(title: "Trợ Giúp / Góp Ý", imageName: "email")]
    
    func getCategories() -> [RssCategories]{
        return rssCategories
    }
    
    func getMenuItem() -> [MoreMenuItem]{
        return moreMenuItem
    }
    
    func checkScheduled() -> Bool {
        if let isBool = UserDefaults.standard.object(forKey: "checkedScheduled") as? Bool {
            notificationIsScheduled = isBool
        }
        return notificationIsScheduled
        
    }
    func getTime(hour: Int, minute: Int, isScheduled: Bool) {
        dateInfo.hour = hour
        dateInfo.minute = minute
        notificationIsScheduled = isScheduled
        UserDefaults.standard.set(notificationIsScheduled, forKey: "checkedScheduled")
    }


}
