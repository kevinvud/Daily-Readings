//
//  RssCategories.swift
//  Daily Readings
//
//  Created by PoGo on 11/13/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import Foundation

class RssCategories {
    
    var title: String?
    var urlLink: String?
    var imageName: String?
    
    init(title: String, urlLink: String, imageName: String) {
        self.title = title
        self.urlLink = urlLink
        self.imageName = imageName
    }

}
