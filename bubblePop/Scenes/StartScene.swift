//
//  StartScene.swift
//  bubblePop
//

import SpriteKit
import GameplayKit

class StartScene: SKScene, ButtonDelegate {
    
    private var singlePlayerButton: Button!
    private var multiplayerButton: Button!
    
    override func didMove(to view: SKView) {
        setupScene()
        setupButtons()
    }
    
    private func setupScene() {
        // Set background color
        backgroundColor = SKColor.white
        
        // Add title
        let titleLabel = SKLabelNode(text: "Bubble Pop")
        titleLabel.fontName = "Arial-BoldMT"
        titleLabel.fontSize = 48
        titleLabel.fontColor = .label
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(titleLabel)
    }
    
    private func setupButtons() {
        // Create Single Player button
        singlePlayerButton = Button(text: "Single Player", fontSize: 20, buttonId: "singlePlayer")
        singlePlayerButton.position = CGPoint(x: frame.midX, y: frame.midY)
        singlePlayerButton.buttonDelegate = self
        addChild(singlePlayerButton)
        
        // Create Multiplayer button
        multiplayerButton = Button(text: "Multiplayer", fontSize: 20, buttonId: "multiplayer")
        multiplayerButton.position = CGPoint(x: frame.midX, y: frame.midY - 80)
        multiplayerButton.buttonDelegate = self
        addChild(multiplayerButton)
    }
    
    func buttonClicked(button: Button) {
        switch button.buttonId {
        case "singlePlayer":
            print("Single Player selected")
            // Transition to single player game scene
            transitionToGameScene(multiplayer: false)
            
        case "multiplayer":
            print("Multiplayer selected")
            // Transition to multiplayer game scene
            transitionToGameScene(multiplayer: true)
            
        default:
            break
        }
    }
    
    private func transitionToGameScene(multiplayer: Bool) {
        if multiplayer {
            print("Would transition to multiplayer game scene")
        } else {
            if let gameScene = SKScene(fileNamed: "GameScene") as? GameScene {
                gameScene.scaleMode = .aspectFill
                gameScene.size = self.size
                        
                let transition = SKTransition.fade(withDuration: 0.75)
                view?.presentScene(gameScene, transition: transition)
           }
        }
    }
}
