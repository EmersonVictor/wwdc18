import PlaygroundSupport
import SpriteKit


public class PurpleScene: ObstaclesScene {
    override public func didMove(to view: SKView) {
        // Setup physics world
        self.setupPhysicsWorld()
        
        // Setup scene
        self.backgroundColor = grayColors.lighter
        self.scaleMode = .aspectFill
        
        // Start scene nodes
        self.setupPerson()
        self.customPerson()
        self.setupCircumference(withColor: rainbowColors.purple, radiusOf: 15/2)
        self.setupAceptance(rainbowColors.purple)
    }
    
    // Custom person
    func customPerson() {
        let colors = [
            rainbowColors.red,
            rainbowColors.orange,
            rainbowColors.yellow,
            rainbowColors.green,
            rainbowColors.blue,
        ]
        
        let radius: [CGFloat] = [
            90/2,
            75/2,
            60/2,
            45/2,
            30/2,
        ]
        
        for (color, radius) in zip(colors, radius) {
            let redCircum = SKShapeNode(circleOfRadius: radius)
            redCircum.fillColor = UIColor.black
            redCircum.lineWidth = 4
            redCircum.strokeColor = color
            redCircum.position = CGPoint(x: 0, y: 0)
            
            self.personNode.addChild(redCircum)
        }
    }
    
    // Physics bodies colission
    override public func didBegin(_ contact: SKPhysicsContact) {
        self.personNode.removeAction(forKey: "moving")
        if contact.bodyA.categoryBitMask == PhysicsCategory.Acceptance ||
            contact.bodyB.categoryBitMask == PhysicsCategory.Acceptance {
            
            // Actions
            let acceptYourself = SKAction.fadeOut(withDuration: 0.5)
            let fadeIn = SKAction.fadeIn(withDuration: 0.5)
            
            self.acceptanceCircumference.run(fadeIn)
            self.acceptanceNode.run(acceptYourself, completion: {() -> Void in
                // Next view
            })
            
        }
    }
}
