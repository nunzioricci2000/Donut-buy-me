//
//  Obstacle.swift
//  Granchio
//
//  Created by Nunzio Ricci on 13/12/22.
//

import SpriteKit

class Obstacle: SKSpriteNode, GameObject {
    private static let obstacles: [SKTexture] = {
        var obstacles: [SKTexture] = []
        for i in 0...7 {
            obstacles.append(.init(pixelart: "obstacle/\(i)"))
        }
        return obstacles
    }()
    
    convenience init(_ position: CGPoint) {
        let texture = Obstacle.obstacles.randomElement()!
        self.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false
    }
    
    func onCreate() {
        self.removeFromParent()
    }
    
    func onUpdate(_ deltaTime: TimeInterval) {
        position.x -= deltaTime * (game?.velocity ?? 1)
        if position.x <= -300 {
            self.removeFromParent()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
}
