//
//  Emitter.swift
//  Daily Readings
//
//  Created by PoGo on 12/18/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class Emitter{
    static func get(with image: UIImage) -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterCells = generateEmitterCells(with: image)
        
        return emitter
    }
    
    static func generateEmitterCells(with image: UIImage) -> [CAEmitterCell] {
        
        var cells = [CAEmitterCell]()
        let cell = CAEmitterCell()
        cell.spin = 0.4
        cell.contents = image.cgImage
        cell.birthRate = 0.5
        cell.lifetime = 30
        cell.velocity = CGFloat(50)
        cell.emissionLongitude = (180 * (.pi/180))
        cell.emissionRange = (45 * (.pi/180))
        cell.scale = 0.4
        cell.scaleRange = 0.3
        cells.append(cell)
        return cells
        
    }
    
}

