//
//  ReadingsContent.swift
//  Daily Readings
//
//  Created by PoGo on 10/26/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class ReadingsContent {
    
    var dateLabel: String?
    var reading1: String?
    var reading2: String?
    var gospel: String?
    var imageViewUrl: String?
    
    init(dictionary: [String: Any], dateLabel: String) {
        self.dateLabel = dateLabel 
        self.reading1 = dictionary["reading1"] as? String ?? ""
        self.reading2 = dictionary["reading2"] as? String ?? ""
        self.gospel = dictionary["gospel"] as? String ?? ""
        self.imageViewUrl = dictionary["imageUrl"] as? String ?? ""
    }

}
