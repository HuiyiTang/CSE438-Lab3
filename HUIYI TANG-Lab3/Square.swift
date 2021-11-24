//
//  Square.swift
//  HUIYI TANG-Lab3
//
//  Created by Huiyi Tang on 10/4/21.
//

import UIKit

class Square: Shape {
    
    required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
    }
    
    override func draw() {
        
        let startX = origin.x - size / 2
        let startY = origin.y - size / 2
        
        color.withAlphaComponent(opacity).setFill()
        path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX + size, y: startY))
        path.addLine(to: CGPoint(x: startX + size, y: startY + size))
        path.addLine(to: CGPoint(x: startX, y: startY + size))
        path.rotate(by: rotate)
        path.fill()
    }
}
