//
//  Donut.swift
//  Granchio
//
//  Created by Nunzio Ricci on 12/12/22.
//

import SpriteKit
import GameplayKit


class Donut: SKSpriteNode, GameObject {
    var tapped: Bool = false
    var objectTouched: Int = 0
    var touchingGround: Bool {
        objectTouched > 0
    }
    var currentFrame: SKTexture {
        Donut.frames[Int((game!.distance / 9.42).rounded()) % 8]
    }
    var startingPosition: CGPoint?
    
    var velocity: CGVector {
        physicsBody?.velocity ?? .init(dx: 0, dy: 0)
    }
    lazy var lastVelocity: CGVector = velocity
    var deltaTime: CGFloat = 1/60
    var acceleration: CGVector {
        .init(dx: (velocity.dx - lastVelocity.dx) / deltaTime,
              dy: (velocity.dy - lastVelocity.dy) / deltaTime)
    }
    var jumpSound = SKAction.playSoundFileNamed("Jump.mp3", waitForCompletion: false)
    var jumpUp = {
        var textures = [SKTexture]()
        for i in 0...5 {
            textures.append(.init(pixelart: "donut/up/\(i)"))
        }
        return SKAction.animate(with: textures,timePerFrame: 0.1)
    }()
    
    fileprivate static let frames: [SKTexture] = {
        var frames: [SKTexture] = []
        for i in 0...9 {
            frames.append(.init(pixelart: "donut/\(i)"))
        }
        return frames
    }()
    
    func onCreate() {
        if startingPosition == nil {
            startingPosition = position
            constraints = [
                .positionX(.init(upperLimit: position.x))
            ]
        } else {
            position = startingPosition!
        }
        physicsBody?.isDynamic = true
        tapped = false
        
        
    }
    
    func constrainVelocity() {
        
    }
    
    func onUpdate(_ deltaTime: TimeInterval) {
        self.deltaTime = deltaTime
        print(acceleration)
        texture = currentFrame
        if acceleration.dy == 0, tapped {
            jump()
        }
        lastVelocity = velocity
    }
    
    func jump() {
        physicsBody?.applyImpulse(.init(dx: 0, dy: 8))
        self.run(jumpSound)
        // self.run(jumpUp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
