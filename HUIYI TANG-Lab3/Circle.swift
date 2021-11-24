//
//  Circle.swift
//  HUIYI TANG-Lab3
//
//  Created by Huiyi Tang on 10/1/21.
//

import UIKit

class Circle: Shape {
    
    required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
    }
    
    override func draw() {
        
        print(size)
        color.withAlphaComponent(opacity).setFill()
        path = UIBezierPath()
        path.addArc(withCenter: origin, radius: size, startAngle: 0, endAngle: CGFloat(Float.pi*2), clockwise: true)
        path.rotate(by: rotate)
        path.fill()
    }
}
