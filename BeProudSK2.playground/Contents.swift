import PlaygroundSupport
import SpriteKit

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Person: UInt32 = 0b1       // Person
    static let Obstacles: UInt32 = 0b10   // Obstacles
    static let Acceptance: UInt32 = 0b101 // Acceptance
}


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 540))
let startScene = RedScene(size: CGSize(width: 750, height: 540))
startScene.backgroundColor = UIColor.gray
startScene.scaleMode = .aspectFill
sceneView.presentScene(startScene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

