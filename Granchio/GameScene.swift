//
//  GameScene.swift
//  Granchio
//
//  Created by Nunzio Ricci on 12/12/22.
//

import SpriteKit

class GameScene: SKScene {
    var donut: Donut!
    
    override func didMove(to view: SKView) {
        donut = childNode(withName: "donut") as? Donut
        addChild(SKSpriteNode(color: .white, size: .init(width: 24, height: 24)))
        removeAntialising()
    }
    
    func removeAntialising(from node: SKNode? = nil) {
        let children = node?.children ?? children
        for child in children {
            removeAntialising(from: child)
            guard let child = child as? SKSpriteNode else { continue }
            child.texture?.filteringMode = .nearest
        }
    }
}
