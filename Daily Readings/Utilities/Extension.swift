//
//  Extension.swift
//  Daily Readings
//
//  Created by PoGo on 10/25/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
        
    }
    
    static func mainBlue() -> UIColor {
        return UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
//        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        self.layer.insertSublayer(gradientLayer, at: 0)
//        layer.addSublayer(gradientLayer)

    }
    
}

extension UserDefaults {
    
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData
        }
        set(colorData, forKey: key)
    }
    
}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let VNDateFormatter = DateFormatter()
        VNDateFormatter.dateFormat = "EEEE, d MMMM"
        VNDateFormatter.locale = Locale(identifier: "vi_VN")
        
        let dateCheckAfterFormat = VNDateFormatter.string(from: self).uppercased()
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "giây"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "phút"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "giờ"
        } else {
            quotient = 0
            unit = dateCheckAfterFormat
        }
        
        if quotient == 0 {
            
            return unit
        
        }else {
        
            return "\(quotient) \(unit) trước"
        
        }
        
//        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
        
    }
}



