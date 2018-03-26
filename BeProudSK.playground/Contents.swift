//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
    
    private var label : SKLabelNode!
    private var spinnyNode : SKShapeNode!
    
    override func didMove(to view: SKView) {
        // Create shape node to use during mouse interaction
        let w = (size.width + size.height) * 0.05
        
        spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w))
        spinnyNode.lineWidth = 2.5
        self.addChild(spinnyNode)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print(self.spinnyNode.position)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.spinnyNode.position = CGPoint(x: pos.x , y: pos.y)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print("lalala")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self))}
    }
}

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
