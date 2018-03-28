
import PlaygroundSupport
import SpriteKit
import UIKit

//// Font
//let cfURL = Bundle.main.url(forResource: "BarlowCondensed-Regular", withExtension: "ttf")! as CFURL
//CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
//

// Colors
public struct GrayColors {
    let darker = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
    let dark = UIColor(red:0.32, green:0.32, blue:0.32, alpha:1.0)
    let normal = UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.0)
    let soft = UIColor(red:0.56, green:0.56, blue:0.56, alpha:1.0)
    let light = UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0)
    let lighter = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
}

public struct RainbowColors {
    let red = UIColor(red:0.98, green:0.33, blue:0.33, alpha:1.0)
    let orange = UIColor(red:1.00, green:0.62, blue:0.15, alpha:1.0)
    let yellow = UIColor(red:1.00, green:0.99, blue:0.35, alpha:1.0)
    let green = UIColor(red:0.47, green:0.84, blue:0.44, alpha:1.0)
    let blue = UIColor(red:0.18, green:0.36, blue:0.99, alpha:1.0)
    let purple = UIColor(red:0.58, green:0.15, blue:0.65, alpha:1.0)
}

public let grayColors = GrayColors()
public let rainbowColors = RainbowColors()

// Physics category
public struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Person: UInt32 = 0b1       // Person
    static let Obstacles: UInt32 = 0b10   // Obstacles
    static let Acceptance: UInt32 = 0b101 // Acceptance
}

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


//////////////////////////////////////////////////////

public class RedScene: ObstaclesScene {
    override public func didMove(to view: SKView) {
        // Setup physics world
        self.setupPhysicsWorld()
        
        // Setup scene
        self.backgroundColor = grayColors.darker
        self.scaleMode = .aspectFill
        
        // Start scene nodes
        self.setupPerson()
        self.setupObstacles()
        self.setupAceptance(rainbowColors.red)
    }
    
    // Setup obstacles
    func setupObstacles() {
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
    
    // Physics bodies colission
    override public func didBegin(_ contact: SKPhysicsContact) {
        self.personNode.removeAction(forKey: "moving")
        if contact.bodyA.categoryBitMask == PhysicsCategory.Acceptance ||
            contact.bodyB.categoryBitMask == PhysicsCategory.Acceptance {
            
            let acceptYourself = SKAction.fadeOut(withDuration: 1)
            self.acceptanceNode.run(acceptYourself)
            
            // Next view
            let orangeView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 540))
            let orangeScene = RedScene(size: CGSize(width: 750, height: 540))
            
            orangeView.presentScene(orangeScene)
            PlaygroundPage.current.liveView = orangeView
        }
    }
}




let orangeView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 540))
let orangeScene = RedScene(size: CGSize(width: 750, height: 540))

orangeView.presentScene(orangeScene)
PlaygroundPage.current.liveView = orangeView
