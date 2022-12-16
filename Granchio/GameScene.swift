//
//  GameScene.swift
//  Granchio
//
//  Created by Nunzio Ricci on 12/12/22.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate, GameObject {
    var donut: Donut!
    var points: Points!
    var startButton: SKSpriteNode!
    var lastTime: TimeInterval? = nil
    var distance: Double = 0
    var velocity: Double {
        sqrt(distance) + 100
    }
    var onLose: ((Int, GameScene)->())?
    var started: Bool = false
    var firstTime: Bool = true
    var cutscene: CutScene?
    
    convenience init?(onLose: ((Int, GameScene) -> Void)? = nil) {
        self.init(fileNamed: "GameScene")
        self.onLose = onLose
    }
    
    override func didMove(to view: SKView) {
        _create()
    }
    
    func onCreate() {
        if firstTime {
            firstTime = false
            cutscene = CutScene()
            addChild(cutscene!)
        }
        distance = 0
        physicsWorld.contactDelegate = self
        physicsWorld.gravity.dx = 1
        removeAntialising()
        isPaused = false
        started = false
        donut = childNode(withName: "donut") as? Donut
        points = childNode(withName: "points") as? Points
        startButton = (childNode(withName: "startButton") as! SKSpriteNode)
    }
    
    func onUpdate(_ delta: TimeInterval) {
        if donut.position.x <= -211 {
            lose()
        }
        if !isPaused {
            distance += velocity * delta
            points.value = Int(distance.rounded())/10
        }
    }
    
    func _update(_ deltaTime: TimeInterval) {
        if !isPaused, started {
            onUpdate(deltaTime)
            for child in children {
                guard let child = child as? GameObject else { continue }
                child._update(deltaTime)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let lastTime = lastTime else {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        self.lastTime = currentTime
        _update(deltaTime)
        self.startButton.isHidden = started
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPaused {
            _create()
            return
        }
        if !started {
            start()
        }
        guard let _ = touches.first else { return }
        donut.tapped = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = touches.first else { return }
        donut.tapped = false
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard [contact.bodyA.node, contact.bodyB.node].contains(donut) else { return }
        //if contact.contactNormal.dx < -0.5 { lose() }
        donut.objectTouched += 1
    }
    
    
    
    func didEnd(_ contact: SKPhysicsContact) {
        guard [contact.bodyA.node, contact.bodyB.node].contains(donut) else { return }
        donut.objectTouched -= 1
    }
    
    func start() {
        points.value = 0
        started = true
    }
    
    func lose() {
        isPaused = true
        donut.physicsBody?.isDynamic = false
        onLose?(points.value, self)
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
