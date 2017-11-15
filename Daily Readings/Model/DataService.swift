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
    
    
    let rssCategories = [RssCategories(title: "Tin Giáo Hội Việt Nam", urlLink: "http://baoconggiao.net/index.php/rss/tin-giao-hoi-viet-nam/", imageName: "Tin Vietnam"),
                         RssCategories(title: "Tin Vatican", urlLink: "http://baoconggiao.net/index.php/rss/tin-vatican/", imageName: "Tin Vatican"),
                         RssCategories(title: "Tin Công Giáo Thế Giới", urlLink: "http://baoconggiao.net/index.php/rss/tin-cong-giao-the-gioi/", imageName: "Tin The Gioi"),
                         RssCategories(title: "Tin Giáo Xứ - Hội Đoàn", urlLink: "http://baoconggiao.net/index.php/rss/tin-giao-xu-hoi-doan/", imageName: "Tin Cong Dong")]
    
    func getCategories() -> [RssCategories]{
        
        return rssCategories
        
    }
    
    
    
}
