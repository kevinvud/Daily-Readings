//
//  DataService.swift
//  Daily Readings
//
//  Created by PoGo on 11/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    var dateInfo = DateComponents()

    
    let rssCategories = [RssCategories(title: "Tin Giáo Hội Việt Nam", urlLink: "http://baoconggiao.net/index.php/rss/tin-giao-hoi-viet-nam/", imageName: "Tin Vietnam"),
                         RssCategories(title: "Tin Vatican", urlLink: "http://baoconggiao.net/index.php/rss/tin-vatican/", imageName: "Tin Vatican"),
                         RssCategories(title: "Tin Công Giáo Thế Giới", urlLink: "http://baoconggiao.net/index.php/rss/tin-cong-giao-the-gioi/", imageName: "Tin The Gioi"),
                         RssCategories(title: "Tin Giáo Xứ - Hội Đoàn", urlLink: "http://baoconggiao.net/index.php/rss/tin-giao-xu-hoi-doan/", imageName: "Tin Cong Dong")]
    
    let moreMenuItem = [MoreMenuItem(title: "Đánh Giá Ứng Dụng", imageName: "rate"),
                        MoreMenuItem(title: "Theo dõi trên trang Facebook", imageName: "followFacebook"),
                        MoreMenuItem(title: "Chia Sẻ", imageName: "share"),
                        MoreMenuItem(title: "Bật Thông Báo Lễ Hằng Ngày", imageName: "alarm"),
                        MoreMenuItem(title: "Đóng Góp", imageName: "donate"),
                        MoreMenuItem(title: "Trợ Giúp / Góp Ý", imageName: "email")]
    
    
    func getCategories() -> [RssCategories]{
        
        return rssCategories
        
    }
    
    func getMenuItem() -> [MoreMenuItem]{
        return moreMenuItem
    }
    
    func getTime(hour: Int, minute: Int) {
        
        dateInfo.hour = hour
        dateInfo.minute = minute
        
        //        // Store value using User Defaults
        //        let currentDate = datePicker.date
        //        NSUserDefaults.standardUserDefaults().setObject(currentDate, forKey: "Current-Date")
        //
        //        // Retrieve Value using User Defaults
        //        if let date = NSUserDefaults.standardUserDefaults().objectForKey("Current-Date") as? NSDate {
        //            datePicker.setDate(date, animated: true)
        //        }
        
    }


}
