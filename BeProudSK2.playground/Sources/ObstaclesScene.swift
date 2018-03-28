import SpriteKit


public class ObstaclesScene: SKScene, SKPhysicsContactDelegate {
    var personNode = SKShapeNode(circleOfRadius: 45)
    var acceptanceNode = SKShapeNode(rectOf: CGSize(width: 20, height: 20), cornerRadius: 3)
    
    // Setup physics world
    func setupPhysicsWorld() {
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    // Setup person node
    func setupPerson() {
        let person = self.personNode
        let body = SKPhysicsBody(circleOfRadius: 45)
        
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
    
    // Setup "acceptance"
    func setupAceptance(_ color: UIColor) {
        let acceptance = self.acceptanceNode
        acceptance.position = CGPoint(x: 698, y: 305)
        acceptance.fillColor = color
        acceptance.lineWidth = 0
        acceptance.zRotation = 40
        
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
        if pos.x < 250 {
            let moveAction = SKAction.moveTo(x: 0, duration: 3)
            self.personNode.run(moveAction, withKey: "moving")
        } else if pos.x > 500 {
            let moveAction = SKAction.moveTo(x: 750, duration: 3)
            self.personNode.run(moveAction, withKey: "moving")
        } else if pos.y >= 270 {
            let moveAction = SKAction.moveTo(y: 500, duration: 3)
            self.personNode.run(moveAction, withKey: "moving")
        } else if pos.y < 250 {
            let moveAction = SKAction.moveTo(y: 0, duration: 3)
            self.personNode.run(moveAction, withKey: "moving")
        }
    }
}

