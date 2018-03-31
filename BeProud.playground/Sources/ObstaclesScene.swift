import SpriteKit

public class ObstaclesScene: SKScene, SKPhysicsContactDelegate {
    var personNode = SKShapeNode(circleOfRadius: 36)
    var acceptanceNode = SKShapeNode(rectOf: CGSize(width: 17, height: 17), cornerRadius: 3)
    var acceptanceCircumference = SKShapeNode(circleOfRadius: 0)
    
    // Setup physics world
    func setupPhysicsWorld() {
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    // Setup person node
    func setupPerson() {
        let person = self.personNode
        let body = SKPhysicsBody(circleOfRadius: 37)
        
        person.isAntialiased = false
        person.lineWidth = 0
        person.fillColor = UIColor.black
        person.position = CGPoint(x: 50, y: 400)
        
        
        person.physicsBody = body
        person.physicsBody?.affectedByGravity = false
        person.physicsBody?.mass = 9999
        person.physicsBody?.restitution = 20
        person.physicsBody?.categoryBitMask = PhysicsCategory.Person
        person.physicsBody?.contactTestBitMask = PhysicsCategory.Acceptance
        person.physicsBody?.collisionBitMask = PhysicsCategory.Obstacles
        person.physicsBody?.friction = 0
        
        
        self.addChild(person)
    }
    
    // Setup acceptance circumference
    func setupCircumference(withColor color: UIColor, radiusOf radius: CGFloat) {
        self.acceptanceCircumference = SKShapeNode(circleOfRadius: radius)
        
        let circum = self.acceptanceCircumference
        circum.position = CGPoint(x: 0, y: 0)
        circum.fillColor = UIColor.black
        circum.lineWidth = 6
        circum.strokeColor = color
        circum.alpha = 0
        
        self.personNode.addChild(circum)
    }
    
    // Setup acceptance
    func setupAceptance(_ color: UIColor) {
        let acceptance = self.acceptanceNode
        acceptance.position = CGPoint(x: 698, y: 260)
        acceptance.fillColor = color
        acceptance.lineWidth = 0
        acceptance.zRotation = 40
        
        // Animation
        let moveUp = SKAction.moveTo(y: 263, duration: 1)
        let moveDown = SKAction.moveTo(y: 257, duration: 1)
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
    public func didBegin(_ contact: SKPhysicsContact) {
        self.personNode.removeAction(forKey: "moving")
        if contact.bodyA.categoryBitMask == PhysicsCategory.Acceptance ||
            contact.bodyB.categoryBitMask == PhysicsCategory.Acceptance {
            
            let acceptYourself = SKAction.fadeOut(withDuration: 1)
            self.acceptanceNode.run(acceptYourself)
        }
    }
    
    // User touches began
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.move(to: t.location(in: self)) }
    }
    
    // Move "person"
    func move(to pos: CGPoint) {
        if pos.x < 200 {
            let moveAction = SKAction.moveTo(x: 0, duration: 1.7)
            self.personNode.run(moveAction, withKey: "moving")
        } else if pos.x > 550 {
            let moveAction = SKAction.moveTo(x: 750, duration: 1.7)
            self.personNode.run(moveAction, withKey: "moving")
        } else if pos.y >= 223 {
            let moveAction = SKAction.moveTo(y: 446, duration: 1.7)
            self.personNode.run(moveAction, withKey: "moving")
        } else if pos.y < 223 {
            let moveAction = SKAction.moveTo(y: 0, duration: 1.7)
            self.personNode.run(moveAction, withKey: "moving")
        }
    }
}


