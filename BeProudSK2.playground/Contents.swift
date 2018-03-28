import PlaygroundSupport
import SpriteKit

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Person: UInt32 = 0b1       // Person
    static let Obstacles: UInt32 = 0b10   // Obstacles
    static let Acceptance: UInt32 = 0b101 // Acceptance
}

public class RedScene: SKScene, SKPhysicsContactDelegate {
    var personNode = SKShapeNode(circleOfRadius: 45)
    var acceptanceNode = SKShapeNode(rectOf: CGSize(width: 20, height: 20), cornerRadius: 3)
    
    override public func didMove(to view: SKView) {
        // Setting up physics word
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        self.createPerson()
        self.createObstacles()
        self.createAceptance()
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    func createPerson() {
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
        
        self.addChild(person)
    }
    
    func createObstacles() {
        let sizes = [
            (w: 10, h: 240), // 1
            (w: 250, h: 10), // 2
            (w: 10, h: 240), // 3
            (w: 500, h: 10), // 4
            (w: 10, h: 445), // 5
            (w: 110, h: 10), // 6
            (w: 10, h: 110), // 7
        ]
        
        let positions = [
            CGPoint(x: 140, y: 300), // 1
            CGPoint(x: 0, y: 200),   // 2
            CGPoint(x: 250, y: 200), // 3
            CGPoint(x: 125, y: 95),  // 4
            CGPoint(x: 440, y: 95),  // 5
            CGPoint(x: 640, y: 250), // 6
            CGPoint(x: 640, y: 250), // 7
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
    
    func createAceptance() {
        let acceptance = self.acceptanceNode
        acceptance.position = CGPoint(x: 698, y: 305)
        acceptance.fillColor = UIColor.red
        acceptance.strokeColor = UIColor.red
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
    
    public func didBegin(_ contact: SKPhysicsContact) {
        self.personNode.removeAction(forKey: "moving")
        if contact.bodyA.categoryBitMask == PhysicsCategory.Acceptance ||
            contact.bodyB.categoryBitMask == PhysicsCategory.Acceptance {
            
            let acceptYourself = SKAction.fadeOut(withDuration: 1)
            self.acceptanceNode.run(acceptYourself)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.move(to: t.location(in: self)) }
    }
    
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


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 540))
let startScene = RedScene(size: CGSize(width: 750, height: 540))
startScene.backgroundColor = UIColor.gray
startScene.scaleMode = .aspectFill
sceneView.presentScene(startScene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

