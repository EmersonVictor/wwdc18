import PlaygroundSupport
import SpriteKit



public class Scene: SKScene {
    
    public override func didMove(to view: SKView) {
        self.createCircle()
    }
    
    func createCircle() {
        let circle = SKShapeNode(circleOfRadius: 0.5)
//        circle.position = CGPoint(x: -10.0, y: 0.0)
        circle.fillColor = .black
        self.addChild(circle)
    }
}


// Creating SceneView
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
let scene = Scene()

scene.scaleMode = .aspectFit
scene.backgroundColor = .white
sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
