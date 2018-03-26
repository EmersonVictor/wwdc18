import PlaygroundSupport
import SpriteKit

public class RedScene: SKScene {
    var personNode = SKShapeNode(circleOfRadius: 45)
    
    override public func didMove(to view: SKView) {
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
        
        self.addChild(person)
    }
    
    func createObstacles() {
        var obstacles = [
            CGRect(x: 0, y: 0, width: 6, height: 240), // 1
            CGRect(x: 0, y: 0, width: 30, height: 6), // 2
        ]
        
        var physicsBodies = [
            CGSize(width: 6, height: 400), // 1
            CGSize(width: 300, height: 6), // 2
        ]
        
        var positions = [
            CGPoint(x: 140, y: 500 - 240), // 1
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
            
            self.addChild(wall)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print(self.personNode.position)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let personPostion = self.personNode.position
        
        if pos.x < 250 {
            if self.nodes(at: CGPoint(x:personPostion.x - 45.1, y: personPostion.y)).isEmpty {
                self.personNode.position = CGPoint(x: personPostion.x - 2, y: personPostion.y)
            }
        } else if pos.x > 500 {
            if self.nodes(at: CGPoint(x:personPostion.x + 45.1, y: personPostion.y)).isEmpty {
                self.personNode.position = CGPoint(x: personPostion.x + 2, y: personPostion.y)
            }
        } else if pos.y >= 250 {
            if self.nodes(at: CGPoint(x:personPostion.x, y: personPostion.y + 45.1)).isEmpty {
                self.personNode.position = CGPoint(x: personPostion.x, y: personPostion.y + 2)
            }
        } else {
            if self.nodes(at: CGPoint(x:personPostion.x, y: personPostion.y - 45.1)).isEmpty {
                self.personNode.position = CGPoint(x: personPostion.x, y: personPostion.y - 2)
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self))}
    }
}


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 500))
let startScene = RedScene(size: CGSize(width: 750, height: 500))
startScene.backgroundColor = UIColor.gray

startScene.scaleMode = .aspectFill
sceneView.presentScene(startScene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

