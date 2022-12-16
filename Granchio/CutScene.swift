//
//  CutScene.swift
//  Granchio
//
//  Created by Nunzio Ricci on 15/12/22.
//

import SpriteKit


class CutScene: SKSpriteNode, GameObject {
    
    let frameDuration = 0.2
    let framesNumber = 27
    let startTime: TimeInterval = 0
    var currentTime: TimeInterval = 0
    var sprite: SKTexture? {
        if frameDuration * Double(framesNumber) < currentTime {
            self.removeFromParent()
        }
        let num = Int(currentTime / frameDuration) % 27 + 1
        return SKTexture(pixelart: "launchscreen/\(num)")
    }
    
    func onCreate() {
        texture = sprite
    }
    
    func onUpdate(_ deltaTime: TimeInterval) {
        currentTime += deltaTime
        texture = sprite
        zPosition = 1
    }
}
