//
//  Button.swift
//  bubblePop
//
//  Created by Nadaa Shafa Nadhifa on 10/06/25.
//

import SpriteKit
import GameplayKit

protocol ButtonDelegate: AnyObject {
    func buttonClicked(button: Button)
}

class Button: SKSpriteNode {
    
    enum TouchType: Int {
        case down, up
    }
    
    weak var buttonDelegate: ButtonDelegate?
    private var type: TouchType = .down
    private var isPressed: Bool = false
    
    // Add an identifier to distinguish between buttons
    var buttonId: String = ""
    
    init(texture: SKTexture, type: TouchType = .up, buttonId: String = "") {
        let size = texture.size()
        self.type = type
        self.buttonId = buttonId
        
        super.init(texture: texture, color: .clear, size: size)
        
        // Enable user interaction
        self.isUserInteractionEnabled = true
        
        // Add some visual feedback
        self.name = "button_\(buttonId)"
    }
    
    // Convenience initializer for text buttons
    convenience init(text: String, fontSize: CGFloat = 24, type: TouchType = .up, buttonId: String = "") {
        // Create a simple colored rectangle as background
        let texture = SKTexture()
        self.init(texture: texture, type: type, buttonId: buttonId)
        
        // Remove the texture and use color instead
        self.texture = nil
        self.color = SKColor.systemBlue
        self.size = CGSize(width: 200, height: 60)
        
        // Add text label
        let label = SKLabelNode(text: text)
        label.fontName = "Arial-BoldMT"
        label.fontSize = fontSize
        label.fontColor = .white
        label.position = CGPoint(x: 0, y: -8) // Slight offset to center vertically
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        self.addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = true
        
        // Add visual feedback
        self.alpha = 0.7
        self.setScale(0.95)
        
        if type == .down {
            self.buttonDelegate?.buttonClicked(button: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: parent!)
            
            if !frame.contains(touchLocation) {
                isPressed = false
                // Reset visual state
                self.alpha = 1.0
                self.setScale(1.0)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset visual state
        self.alpha = 1.0
        self.setScale(1.0)
        
        guard isPressed else { return }
        
        if type == .up {
            self.buttonDelegate?.buttonClicked(button: self)
        }
        
        isPressed = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset visual state
        self.alpha = 1.0
        self.setScale(1.0)
        isPressed = false
    }
}
