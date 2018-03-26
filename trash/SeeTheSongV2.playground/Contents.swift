import PlaygroundSupport
import SpriteKit

class MusicScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.createCircles()
        self.animateUpDown()
//        self.animateRotate()
        let blueCircle = self.childNode(withName: "blueCircle")
    }
    
    //// Get the circles
    func getCircles() -> [SKNode] {
        let colors = ["red", "green", "blue"]
        var nodes:[SKNode] = []
        
        for color in colors {
            if let node = self.childNode(withName: "\(color)Circle") {
                nodes.append(node)
            }
        }
        
        return nodes
    }
    
    //// Create the circles
    func createCircles() {
        // Set up the colors
        let colors = [
            UIColor(red:1.00, green:0.00, blue:0.00, alpha:0.6),
            UIColor(red:0.00, green:1.00, blue:0.00, alpha:0.6),
            UIColor(red:0.00, green:0.00, blue:1.00, alpha:0.6)]
        
        // Set up the positions
        let positions = [
            CGPoint(x: 0, y: 0.16),
            CGPoint(x: 0.16, y: -0.11),
            CGPoint(x: -0.16, y: -0.11)]
        
        // Set up the names
        let names = [
            "redCircle",
            "greenCircle",
            "blueCircle"]
        
        for x in 0...2 {
            self.createCircle(of: colors[x], at: positions[x], named: names[x])
        }
    }
    
    //// Create a circle
    func createCircle(of color: UIColor, at position: CGPoint, named: String) {
        
        // Default config
        let circle = SKShapeNode(circleOfRadius: 1.5)
        circle.isAntialiased = false
        circle.lineWidth = 0
        circle.setScale(0.1)
        
        // Editable config
        circle.fillColor = color
        circle.position = position
        circle.name = named
        
        self.addChild(circle)
    }
    
    //// Animate: up and down
    func animateUpDown() {
        let circles = self.getCircles()
        
        // Creating actioon
        let moveUp = SKAction.moveBy(x:0, y: 0.04, duration: 1.3)
        let sequence = SKAction.sequence([moveUp, moveUp.reversed()])
        
        for circle in circles {
            circle.run(SKAction.repeatForever(sequence), withKey:  "moving")
        }
    }
    
    //// Animate: rotate
//    func animateRotate() {
//
//        let circles = self.getCircles()
//
//        // Creating actioon
//        let oneRevolution:SKAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1)
//        let repeatRotation:SKAction = SKAction.repeatForever(oneRevolution)
//
//        for circle in circles {
//            circle.run(repeatRotation)
//        }
//    }

}

let musicView = SKView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
let musicScene = MusicScene()

musicScene.scaleMode = .aspectFill
musicScene.backgroundColor = UIColor.white
musicScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
musicView.presentScene(musicScene)

PlaygroundPage.current.liveView = musicView
