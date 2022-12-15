//
//  Points.swift
//  Granchio
//
//  Created by Nunzio Ricci on 13/12/22.
//

import SpriteKit

class Points: SKNode, GameObject {
    var digits: [Digit] = []
    private var _value: Int = 0
    var value: Int {
        get { _value }
        set {
            let newValue = max(0, min(newValue, 99999))
            var n = 1
            for i in 0...4 {
                let digit = newValue / n % 10
                n *= 10
                digits[i].value = digit
            }
            _value = newValue
        }
    }
    
    func onCreate() {
        for child in children {
            guard let child = child as? Digit else { continue }
            digits.append(child)
        }
        value = 0
    }
    
    func onUpdate(_ deltaTime: TimeInterval) {}
}
