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
    
    let appleAppId = "ca-app-pub-7835361104201283~4375279423"
    
    let rssCategories = [RssCategories(title: "Tin Giáo Hội Việt Nam",urlLink: "http://baoconggiao.net/index.php/rss/tin-giao-hoi-viet-nam/", imageName: "vietnam"),
                         RssCategories(title: "Tin Vatican", urlLink: "http://baoconggiao.net/index.php/rss/tin-vatican/", imageName: "vatican"),
                         RssCategories(title: "Tin Công Giáo Thế Giới", urlLink: "http://baoconggiao.net/index.php/rss/tin-cong-giao-the-gioi/", imageName: "world"),
                         RssCategories(title: "Tin Giáo Xứ - Hội Đoàn", urlLink: "http://baoconggiao.net/index.php/rss/tin-giao-xu-hoi-doan/", imageName: "congdong"),
                         RssCategories(title: "Tin Bác Ái", urlLink: "http://baoconggiao.net/index.php/rss/bac-ai/", imageName: "bacAi")
                         ]
    
    let moreMenuItem = [MoreMenuItem(title: "Đánh giá ứng dụng", imageName: "rate"),
                        MoreMenuItem(title: "Theo dõi trang Facebook", imageName: "followFacebook"),
                        MoreMenuItem(title: "Chia sẻ ứng dụng", imageName: "share"),
                        MoreMenuItem(title: "Giờ thông báo hằng ngày", imageName: "alarm"),
                        MoreMenuItem(title: "Đóng góp", imageName: "donate"),
                        MoreMenuItem(title: "Hỗ trợ / góp ý", imageName: "email")]
    
    let refectionCategories = [ReflectionCategories(title: "Bài Giảng Lòng Thương Xót Chúa", contentText: "Những bài chia sẻ Lm. Giuse Trần Đình Long", urlLink: "http://tinthac.net/index.php/rss/nhat-ky-bai-giang/", imageName: "jesus"),
                               ReflectionCategories(title: "Video Thực Hành Lòng Thương Xót", contentText: "Công tác bác ái ", urlLink: "http://tinthac.net/index.php/rss/nhat-ky-thuc-hanh-long-thuong-xot/", imageName: "maria"),
                               ReflectionCategories(title: "Video Thánh Lễ", contentText: "Thánh lễ tại Giáo Điểm Tin Mừng ", urlLink: "http://tinthac.net/index.php/rss/nhat-ky-video/", imageName: "thanhle")
    ]
    
    
    func getCategories() -> [RssCategories]{
        return rssCategories
    }
    
    func getMenuItem() -> [MoreMenuItem]{
        return moreMenuItem
    }
    
    func getReflectionCategories() -> [ReflectionCategories]{
        return refectionCategories
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
