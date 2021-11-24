//
//  Triangle.swift
//  HUIYI TANG-Lab3
//
//  Created by Huiyi Tang on 10/4/21.
//

import UIKit

class Triangle: Shape {
    
    required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
    }
    
    override func draw() {
        
        let startX = origin.x - size / 2
        let startY = origin.y - (CGFloat(3.squareRoot())/4)*size

        color.withAlphaComponent(opacity).setFill()
        path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX + size, y: startY))
        path.addLine(to: CGPoint(x: startX + size/2, y: startY + (CGFloat(3.squareRoot())/2)*size))
        path.rotate(by: rotate)
        path.fill()
    }
}
