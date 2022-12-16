//
//  Spawner.swift
//  Granchio
//
//  Created by Nunzio Ricci on 13/12/22.
//

import SpriteKit

class Spawner: SKNode, GameObject {
    var spawnTime: TimeInterval {
        33 / (game?.velocity ?? 1)
    }
    var levels: Int = 0
    var lastSpawnAttempt: TimeInterval = 0
    
    func onCreate() {
        levels = 0
    }
    
    func onUpdate(_ deltaTime: TimeInterval) {
        lastSpawnAttempt += deltaTime
        if lastSpawnAttempt >= spawnTime {
            lastSpawnAttempt -= spawnTime
            spawn()
        }
    }
    
    func spawn() {
        let changeLevel = Bool.random()
        if changeLevel {
            levels += Bool.random() ? 1 : -1
        }
        if levels < 0 {
            levels = 1
        } else if levels > 2 {
            levels = 1
        }
        for level in 0..<levels {
            game?.addChild(Obstacle(CGPoint(x: self.position.x, y: self.position.y + CGFloat(32 * level))))
        }
    }
}
