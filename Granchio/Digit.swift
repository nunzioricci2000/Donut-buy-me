//
//  Digit.swift
//  Granchio
//
//  Created by Nunzio Ricci on 13/12/22.
//

import SpriteKit



class Digit: SKSpriteNode {
    
    fileprivate static let digits: [SKTexture] = {
        var digits: [SKTexture] = []
        for i in 0...9 {
            digits.append(.init(pixelart: "digit/\(i)"))
        }
        return digits
    }()
    
    @GKInspectable
    private var _value: Int = 0
    
    var value: Int {
        get {
            _value
        }
        set {
            guard (0...9).contains(newValue) else { return }
            texture = Digit.digits[newValue]
            _value = newValue
        }
    }
}
