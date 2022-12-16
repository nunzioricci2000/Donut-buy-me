//
//  Background.swift
//  Granchio
//
//  Created by Nunzio Ricci on 15/12/22.
//

import SpriteKit

class Background: SKSpriteNode, GameObject {
    
    var sprite: SKTexture? {
        let num = Int((game?.distance ?? 0)/2.25) % 7
        return SKTexture(pixelart: "background/\(num)")
    }
    
    func onCreate() {
        
    }
    
    func onUpdate(_ deltaTime: TimeInterval) {
        texture = sprite
    }
}
