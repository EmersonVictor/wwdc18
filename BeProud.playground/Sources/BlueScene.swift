import PlaygroundSupport
import SpriteKit

public class BlueScene: ObstaclesScene {
    override public func didMove(to view: SKView) {
        // Setup physics world
        self.setupPhysicsWorld()
        
        // Setup scene
        self.backgroundColor = grayColors.light
        self.scaleMode = .aspectFill
        
        // Start scene nodes
        self.setupPerson()
        self.customPerson()
        self.setupCircumference(withColor: rainbowColors.blue, radiusOf: 12)
        self.setupObstacles()
        self.setupAceptance(rainbowColors.blue)
    }
    
    // Custom person
    func customPerson() {
        let colors = [
            rainbowColors.red,
            rainbowColors.orange,
            rainbowColors.yellow,
            rainbowColors.green,
        ]
        
        let radius: [CGFloat] = [
            36,
            30,
            24,
            18,
        ]
        
        for (color, radius) in zip(colors, radius) {
            let redCircum = SKShapeNode(circleOfRadius: radius)
            redCircum.fillColor = UIColor.black
            redCircum.lineWidth = 6
            redCircum.strokeColor = color
            redCircum.position = CGPoint(x: 0, y: 0)
            
            self.personNode.addChild(redCircum)
        }
    }
    
    // Setup obstacles
    func setupObstacles() {
        let sizes = [
            (w: 110, h: 10), // 6
            (w: 10, h: 110), // 7
        ]
        
        let positions = [
            CGPoint(x: 640, y: 200), // 6
            CGPoint(x: 640, y: 200), // 7
        ]
        
        var obstacles: SKShapeNode
        for (size, position) in zip(sizes, positions) {
            obstacles = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.w, height: size.h))
            obstacles.fillColor = UIColor.black
            obstacles.position = position
            obstacles.lineWidth = 0
            
            obstacles.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.w, height: size.h), center: CGPoint(x: size.w/2, y: size.h/2))
            obstacles.physicsBody?.affectedByGravity = false
            obstacles.physicsBody?.pinned = true
            obstacles.physicsBody?.allowsRotation = false
            obstacles.physicsBody?.isDynamic = false
            obstacles.physicsBody?.categoryBitMask = PhysicsCategory.Obstacles
            obstacles.physicsBody?.contactTestBitMask = PhysicsCategory.Person
            obstacles.physicsBody?.collisionBitMask = PhysicsCategory.Person
            obstacles.physicsBody?.mass = 999
            
            self.addChild(obstacles)
        }
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
                let purpleScene = PurpleScene(size: CGSize(width: 750, height: 446))
                let moveInTransition = SKTransition.moveIn(with: SKTransitionDirection.right, duration: 1)
                
                self.view?.presentScene(purpleScene, transition: moveInTransition)
            })
        }
    }
}
