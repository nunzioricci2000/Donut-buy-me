//
//  Spawner.swift
//  Granchio
//
//  Created by Nunzio Ricci on 13/12/22.
//

import SpriteKit

class Spawner: SKNode, GameObject {
    var spawnTime: TimeInterval {
        24 / (game?.velocity ?? 1)
    }
    var lastSpawnAttempt: TimeInterval = 0
    
    func onCreate() {
        
    }
    
    func onUpdate(_ deltaTime: TimeInterval) {
        lastSpawnAttempt += deltaTime
        if lastSpawnAttempt >= spawnTime {
            lastSpawnAttempt -= spawnTime
            spawn()
        }
    }
    
    func spawn() {
        if Bool.random() {
            game?.addChild(Obstacle(self.position))
        }
    }
}
