//
//  ReflectionCategories.swift
//  Daily Readings
//
//  Created by PoGo on 12/6/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import Foundation

class ReflectionCategories {
    
    var title: String?
    var urlLink: String?
    var contentText: String?
    var imageName: String?
    
    init(title: String, contentText: String, urlLink: String, imageName: String) {
        self.title = title
        self.contentText = contentText
        self.urlLink = urlLink
        self.imageName = imageName
    }
    
}
