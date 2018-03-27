import PlaygroundSupport
import SpriteKit

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Person: UInt32 = 0b1      // Person
    static let Obstacles: UInt32 = 0b10  // Obstacles
}

public class RedScene: SKScene, SKPhysicsContactDelegate {
    var personNode = SKShapeNode(circleOfRadius: 45)
    
    override public func didMove(to view: SKView) {
        // Setting up physics word
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        self.createPerson()
        self.createObstacles()
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    func createPerson() {
        let person = self.personNode
        let body = SKPhysicsBody(circleOfRadius: 45)
        
        person.isAntialiased = false
        person.lineWidth = 0
        person.fillColor = UIColor.white
        person.position = CGPoint(x: 50, y: 400)
        person.physicsBody = body
        person.physicsBody?.affectedByGravity = false
        personNode.physicsBody?.mass = 0
        
        self.addChild(person)
    }
    
    func createObstacles() {
        var obstacles = [
            CGRect(x: 0, y: 0, width: 8, height: 240), // 1
            CGRect(x: 0, y: 0, width: 30, height: 8), // 2
        ]
        
        var physicsBodies = [
            CGSize(width: 8, height: 220), // 1
            CGSize(width: 30, height: 8), // 2
        ]
        
        var positions = [
            CGPoint(x: 140, y: 260), // 1
            CGPoint(x: 110, y: 300), // 2
        ]
        
        var wall: SKShapeNode
        for n in 0...obstacles.count - 1 {
            wall = SKShapeNode(rect: obstacles[n])
            wall.fillColor = UIColor.white
            wall.position = positions[n]
            
            wall.physicsBody = SKPhysicsBody(rectangleOf: physicsBodies[n] )
            wall.physicsBody?.affectedByGravity = false
            wall.physicsBody?.pinned = true
            wall.physicsBody?.allowsRotation = false
            wall.physicsBody?.categoryBitMask = PhysicsCategory.Obstacles
            wall.physicsBody?.contactTestBitMask = PhysicsCategory.Person
            wall.physicsBody?.collisionBitMask = PhysicsCategory.Person
            
            self.addChild(wall)
        }
    }
    
    var isTouching = false
//    var haveCollision = false
    var positionOfTouch = CGPoint(x: 0 , y: 0)
    
    public func didBegin(_ contact: SKPhysicsContact) {
        print("have collision")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouching = true
        for t in touches { self.positionOfTouch = t.location(in: self) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouching = false
//        self.haveCollision = false
    }
    
    override public func update(_ currentTime: TimeInterval) {
        if self.isTouching {
            let pos = self.positionOfTouch
            
            if pos.x < 250 {
                self.personNode.position = CGPoint(x: self.personNode.position.x - 1, y: self.personNode.position.y)
            } else if pos.x > 500 {
               self.personNode.position = CGPoint(x: self.personNode.position.x + 1, y: self.personNode.position.y)
            } else if pos.y >= 250 {
                self.personNode.position = CGPoint(x: self.personNode.position.x, y: self.personNode.position.y + 1)
            } else {
               self.personNode.position = CGPoint(x: self.personNode.position.x, y: self.personNode.position.y - 1)
            }
        }
    }
}


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 500))
let startScene = RedScene(size: CGSize(width: 750, height: 500))
startScene.backgroundColor = UIColor.gray

startScene.scaleMode = .aspectFill
sceneView.presentScene(startScene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

