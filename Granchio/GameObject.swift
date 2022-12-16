//
//  GameObject.swift
//  Granchio
//
//  Created by Nunzio Ricci on 12/12/22.
//

import SpriteKit

protocol GameObject: SKNode {
    func onCreate()
    func onUpdate(_ deltaTime: TimeInterval)
}

/*
class SpriteNode: SKSpriteNode {
    convenience init(_ gameObject: GameObject) {
        let gameObject = gameObject as? SKSpriteNode
        //let texture = gameObject?.texture ?? .in
        //self.init(texture: texture, color: .clear, size: texture.size())
    }
    
    func update() {
        position.x = position.x.rounded()
        position.y = position.y.rounded()
    }
}
*/
extension GameObject {
    var game: GameScene? {
        return scene as? GameScene
    }
    
    func fixSpritePosition() {
        guard let self = self as? SKSpriteNode else { return }
        let x = self.position.x
        let y = self.position.y
        let xOffset = x - x.rounded()
        let yOffset = y - y.rounded()
        let xOffsetOverWidth = xOffset / self.size.width
        let yOffsetOverHeight = yOffset / self.size.height
        self.anchorPoint = .init(x: 0.5 + xOffsetOverWidth, y: 0.5 + yOffsetOverHeight)
    }
    
    func _create() {
        onCreate()
        for child in children {
            guard let child = child as? GameObject else { continue }
            child._create()
        }
    }
    
    func _update(_ deltaTime: TimeInterval) {
        onUpdate(deltaTime)
        fixSpritePosition()
        for child in children {
            guard let child = child as? GameObject else { continue }
            child._update(deltaTime)
        }
    }
}

