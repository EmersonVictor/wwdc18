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
        self.setupCircumference(withColor: rainbowColors.purple, radiusOf: 6)
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
            36,
            30,
            24,
            18,
            12,
        ]
        
        for (color, radius) in zip(colors, radius) {
            let circum = SKShapeNode(circleOfRadius: radius)
            circum.fillColor = UIColor.black
            circum.lineWidth = 6
            circum.strokeColor = color
            circum.position = CGPoint(x: 0, y: 0)
            
            self.personNode.addChild(circum)
        }
    }
    
    // Override acceptance setup
    // Setup acceptance
    override func setupAceptance(_ color: UIColor) {
        let acceptance = self.acceptanceNode
        acceptance.position = CGPoint(x: 698, y: 100)
        acceptance.fillColor = color
        acceptance.lineWidth = 0
        acceptance.zRotation = 40
        
        // Animation
        let moveUp = SKAction.moveTo(y: 103, duration: 1)
        let moveDown = SKAction.moveTo(y: 97, duration: 1)
        let sequence = SKAction.sequence([moveUp, moveDown])
        let rotate = SKAction.rotate(byAngle: 10, duration: 15)
        
        
        acceptance.run(SKAction.repeatForever(sequence))
        acceptance.run(SKAction.repeatForever(rotate))
        
        acceptance.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        acceptance.physicsBody?.affectedByGravity = false
        acceptance.physicsBody?.pinned = true
        acceptance.physicsBody?.allowsRotation = false
        acceptance.physicsBody?.isDynamic = false
        acceptance.physicsBody?.categoryBitMask = PhysicsCategory.Acceptance
        acceptance.physicsBody?.contactTestBitMask = PhysicsCategory.Person
        acceptance.physicsBody?.collisionBitMask = PhysicsCategory.Person
        acceptance.physicsBody?.mass = 999
        
        
        self.addChild(acceptance)
    }
    
    // Physics bodies colission
    override public func didBegin(_ contact: SKPhysicsContact) {
        self.personNode.removeAction(forKey: "moving")
        if contact.bodyA.categoryBitMask == PhysicsCategory.Acceptance ||
            contact.bodyB.categoryBitMask == PhysicsCategory.Acceptance {
            
            // Actions
            let acceptYourself = SKAction.fadeOut(withDuration: 0.7)
            let fadeIn = SKAction.fadeIn(withDuration: 0.7)
            
            self.acceptanceCircumference.run(fadeIn)
            self.acceptanceNode.run(acceptYourself, completion: {() -> Void in
                // Next view
                let finalScene = FinalScene(size: CGSize(width: 750, height: 446))
                let moveInTransition = SKTransition.moveIn(with: SKTransitionDirection.right, duration: 1)
                
                self.view?.presentScene(finalScene, transition: moveInTransition)
            })
            
        }
    }
}
