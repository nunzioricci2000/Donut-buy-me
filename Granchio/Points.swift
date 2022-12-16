//
//  Points.swift
//  Granchio
//
//  Created by Nunzio Ricci on 13/12/22.
//

import SpriteKit

class Points: SKNode, GameObject {
    var digits: [Digit] = []
    var value: Int = 0 {
        didSet {
            value = max(0, min(value, 99999))
            var n = 1
            for i in 0...4 {
                let digit = (value / n) % 10
                n *= 10
                digits[i].value = digit
            }
        }
    }
    
    func onCreate() {
        if digits.isEmpty {
            for child in children {
                guard let child = child as? Digit else { continue }
                digits.append(child)
            }
        }
        value = 0
    }
    
    func onUpdate(_ deltaTime: TimeInterval) {}
}
