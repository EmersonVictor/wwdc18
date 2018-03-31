import PlaygroundSupport
import SpriteKit

public class FinalScene: SKScene {
    override public func didMove(to view: SKView) {
        // Setup scene
        self.backgroundColor = UIColor.white
        self.scaleMode = .aspectFill
        self.createScene()
    }
    
    func createScene() {
        // Ground
        let ground = SKShapeNode(rectOf: CGSize(width: 750, height: 8))
        ground.fillColor = UIColor.black
        ground.position = CGPoint(x: 375, y: 30)
        self.addChild(ground)
        
        // Squares couple
        let square1 = self.createColoredSquare()
        let square2 = self.createColoredSquare()
        
        square1.position = CGPoint(x: 700,y: 73)
        self.addChild(square1)
        
        square2.position = CGPoint(x: 610,y: 73)
        self.addChild(square2)
        
        // Square and circle
        let square3 = self.createColoredSquare()
        let circle1 = self.createColoredCircle()
        
        square3.position = CGPoint(x: 380,y: 73)
        self.addChild(square3)
        
        circle1.position = CGPoint(x: 470,y: 73)
        self.addChild(circle1)
        
        // Circles
        let circle2 = self.createColoredCircle()
        let circle3 = self.createColoredCircle()
        
        circle2.position = CGPoint(x: 200,y: 73)
        self.addChild(circle2)
        
        circle3.position = CGPoint(x: -100, y: 73)
        self.addChild(circle3)
        
        let moveAction = SKAction.moveTo(x: 120, duration: 2)
        circle3.run(moveAction, completion: {() -> Void in
            self.showQuestion()
        })
    }
    
    func createColoredSquare() -> SKShapeNode {
        let square = SKShapeNode(rectOf: CGSize(width: 72, height: 72))
        
        let colors = [
            rainbowColors.red,
            rainbowColors.orange,
            rainbowColors.yellow,
            rainbowColors.green,
            rainbowColors.blue,
            rainbowColors.purple
            ]

        let sizes: [CGFloat] = [
            36*2,
            30*2,
            24*2,
            18*2,
            12*2,
            6*2
            ]

        var insideSquare: SKShapeNode
        for (color, size) in zip(colors, sizes) {
            insideSquare = SKShapeNode(rectOf: CGSize(width: size, height: size))
            insideSquare.fillColor = UIColor.black
            insideSquare.strokeColor = color
            insideSquare.lineWidth = 6

            square.addChild(insideSquare)
        }
        
        return square
    }
    
    func createColoredCircle() -> SKShapeNode {
        let circle = SKShapeNode(circleOfRadius: 36)
        
        let colors = [
            rainbowColors.red,
            rainbowColors.orange,
            rainbowColors.yellow,
            rainbowColors.green,
            rainbowColors.blue,
            rainbowColors.purple,
            ]
        
        let radius: [CGFloat] = [
            36,
            30,
            24,
            18,
            12,
            6
            ]
        
        for (color, radius) in zip(colors, radius) {
            let circum = SKShapeNode(circleOfRadius: radius)
            circum.fillColor = UIColor.black
            circum.lineWidth = 6
            circum.strokeColor = color
            circum.position = CGPoint(x: 0, y: 0)
            
            circle.addChild(circum)
        }
        
        return circle
    }
    
    func showQuestion() {
        // Label setup
        let text = SKLabelNode(fontNamed: "BarlowCondensed-Regular")
        text.position = CGPoint(x: 305, y: 226)
        text.fontSize = 30
        text.fontColor = grayColors.instruction
        text.lineBreakMode = NSLineBreakMode.byWordWrapping
        text.numberOfLines = 2
        text.preferredMaxLayoutWidth = 550
        text.alpha = 0
        
        self.addChild(text)
        
        // Actions for sequence
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 4)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        // Actions
        let fadeSequence = SKAction.sequence([fadeIn, wait, fadeOut])
        
        text.text = question
        text.run(fadeSequence, completion: {() -> Void in
            self.showInformation()
        })
    }
    
    func showInformation() {
        let text = SKSpriteNode(imageNamed: "Information")
        text.position = CGPoint(x: 350, y: 280)
        text.setScale(0.2)
        text.alpha = 0
        self.addChild(text)
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 40)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        // Actions
        let fadeSequence = SKAction.sequence([fadeIn, wait, fadeOut])
        
        text.run(fadeSequence, completion: {() -> Void in
            self.showFinalText()
        })
        
        
    }
    
    func showFinalText() {
        let text = SKSpriteNode(imageNamed: "FinalText")
        text.position = CGPoint(x: 350, y: 280)
        text.setScale(0.45)
        text.alpha = 0
        self.addChild(text)
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 20)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        // Actions
        let fadeSequence = SKAction.sequence([fadeIn, wait, fadeOut])
        
        text.run(fadeSequence, completion: {() -> Void in
            self.showBeProud()
        })
    }
    
    func showBeProud() {
        let words = ["BE", "PROUD", "OF", "WHO", "YOU", "ARE"]
        
        let positions = [
            CGPoint(x: 375, y: 400),
            CGPoint(x: 375, y: 350),
            CGPoint(x: 375, y: 300),
            CGPoint(x: 375, y: 250),
            CGPoint(x: 375, y: 200),
            CGPoint(x: 375, y: 150)
        ]
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.6)
        
        for (word, position) in zip(words, positions) {
            let text = SKLabelNode(fontNamed: "BarlowCondensed-Regular")
            text.fontColor = grayColors.instruction
            text.fontSize = 35
            text.zPosition = 1
            text.alpha = 0
            
            text.text = word
            text.position = position
            
            self.addChild(text)
            text.run(fadeIn)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
            let introView = IntroView()
            introView.preferredContentSize = CGSize(width: 750, height: 446)
            PlaygroundSupport.PlaygroundPage.current.liveView = introView
        })
    }
}
