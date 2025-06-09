//
//  GameScene.swift
//  bubblePop
//
//  Created by Nadaa Shafa Nadhifa on 09/06/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var scoreLabel : SKLabelNode?
    private var timerLabel : SKLabelNode?
    
    var score : Int = 0
    
    class func newGameScene() -> GameScene {
        // load GameScene.sks as an SKScene
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            fatalError("Couldn't load GameScene.sks")
        }
        // set the scale mode to scale fit the window
        scene.scaleMode = .aspectFit
        return scene
    }
    
    func setupScene() {
        
        guard let view = self.view else { return }
        
        let topLeftInView = CGPoint(x: view.bounds.minX + 20, y: view.bounds.minY + 80)
        let topLeft = convertPoint(fromView: topLeftInView)
        timerLabel = childNode(withName: "//timerLabel") as? SKLabelNode
        timerLabel?.position = topLeft
        
        let topRightInView = CGPoint(x: view.bounds.maxX - 20, y: view.bounds.minY + 80)
        let topRight = convertPoint(fromView: topRightInView)
        scoreLabel = childNode(withName: "//scoreLabel") as? SKLabelNode
        scoreLabel?.position = topRight
        
    }
    
    func spawnBubbles() {
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run(spawnBubble),
            SKAction.wait(forDuration: 0.5, withRange: 0.1)
        ])))
    }
    
    func spawnBubble() {
        //let bubbleIndex = Int.random(in: 0...3)
        //let bubble = SKSpriteNode(imageNamed: "bubble\(bubbleIndex)")
        
        let bubble = SKSpriteNode(imageNamed: "bubble")
        bubble.name = "bubble"
        
        bubble.setScale(CGFloat.random(in: 0.02...0.05))
        
        // Generate random X position across screen width
        let randomX = CGFloat.random(in: -size.width/2...size.width/2)
            
        // Start from bottom of screen (below visible area)
        let startY = -size.height/2 - bubble.size.height
        bubble.position = CGPoint(x: randomX, y: startY)
            
        bubble.zPosition = 1
        addChild(bubble)
            
        // Move to top of screen (above visible area)
        let endY = size.height/2 + bubble.size.height
        let totalDistance = endY - startY
        let speed: CGFloat = 100
        let duration = totalDistance / speed
            
        let moveAction = SKAction.moveTo(y: endY, duration: TimeInterval(duration))
        let removeAction = SKAction.removeFromParent()
        bubble.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    override func didMove(to view: SKView) {
        self.setupScene()
        spawnBubbles()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let tapped = atPoint(location)
        if tapped.name == "bubble" {
            tapped.removeFromParent()
            
            score += 1
            scoreLabel?.text = "\(score)"
        }
    }
    
}
