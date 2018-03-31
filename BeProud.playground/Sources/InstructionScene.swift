import PlaygroundSupport
import SpriteKit

public class InstructionScene: SKScene {
    // Rects
    let leftRect = SKShapeNode(rectOf: CGSize(width: 200, height: 446))
    let rightRect = SKShapeNode(rectOf: CGSize(width: 200, height: 446))
    let topRect = SKShapeNode(rectOf: CGSize(width: 350, height: 223))
    let bottomRect = SKShapeNode(rectOf: CGSize(width: 350, height: 223))
    
    // Arrow
    let leftArrow = SKSpriteNode(imageNamed: "Arrow")
    let rightArrow = SKSpriteNode(imageNamed: "Arrow")
    let topArrow = SKSpriteNode(imageNamed: "Arrow")
    let bottomArrow = SKSpriteNode(imageNamed: "Arrow")
    
    override public func didMove(to view: SKView) {
        // Setup scene
        self.backgroundColor = UIColor.black
        self.scaleMode = .aspectFit
        self.createTouchAreas()
        self.animateAreas()
    }
    
    func createTouchAreas() {
        let areasRect = [self.leftRect, self.rightRect, self.topRect, self.bottomRect]
        let areasArrow = [self.leftArrow, self.rightArrow, self.topArrow, self.bottomArrow]
        
        let positions = [
            (x: 100.0 ,y: 223.0),
            (x: 650.0 ,y: 223.0),
            (x: 375.0 ,y: 334.5),
            (x: 375.0 ,y: 111.5),
        ]
        
        let arrowRotations = [
            CGFloat(0),
            CGFloat(.pi/1.0),
            CGFloat((3 * .pi)/2.0),
            CGFloat(.pi/2.0)
        ]
        
        let texts = ["Tap in this area to go LEFT", "Tap in this area to go RIGHT", "Tap in this area to go UP", "Tap in this area to go DOWN"]
        
        for n in 0...3 {
            let rect = areasRect[n]
            let arrow = areasArrow[n]
            let label = SKLabelNode(fontNamed: "BarlowCondensed-Regular")
            
            rect.position = CGPoint(x: positions[n].x, y: positions[n].y)
            rect.fillColor = grayColors.instruction
            rect.strokeColor = UIColor.black
            rect.alpha = 0
            
            label.text = texts[n]
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            label.position = CGPoint(x: 0 , y: -65)
            label.fontSize = 17
            label.fontColor = grayColors.soft
            
            rect.addChild(label)
            
            arrow.position = CGPoint(x: positions[n].x, y: positions[n].y)
            arrow.zRotation = arrowRotations[n]
            arrow.alpha = 0.2
            
            self.addChild(rect)
            self.addChild(arrow)
        }
    }
    
    func fadeIn(_ direciton: String) {
        let fadeIn = SKAction.fadeIn(withDuration: 0.7)
        
        switch direciton {
        case "left":
            self.leftRect.run(fadeIn)
            self.leftArrow.run(fadeIn)
        case "right":
            self.rightRect.run(fadeIn)
            self.rightArrow.run(fadeIn)
        case "top":
            self.topRect.run(fadeIn)
            self.topArrow.run(fadeIn)
        case "bottom":
            self.bottomRect.run(fadeIn)
            self.bottomArrow.run(fadeIn)
        default:
            break
        }
    }
    
    func animateAreas() {
        // Actions for sequence
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 1.3)
        
        // Actions
        let fadeAlpha = SKAction.fadeAlpha(to: 0.3, duration: 0.6)
        let fadeInSequence = SKAction.sequence([fadeIn, wait])
        
        // Left
        self.leftArrow.run(fadeInSequence)
        self.leftRect.run(fadeInSequence, completion: {() -> Void in
            self.leftArrow.run(fadeAlpha)
            self.leftRect.run(fadeAlpha, completion: {() -> Void in
                // Top
                self.topArrow.run(fadeInSequence)
                self.topRect.run(fadeInSequence, completion: {() -> Void in
                    self.topArrow.run(fadeAlpha)
                    self.topRect.run(fadeAlpha, completion: {() -> Void in
                        // Right
                        self.rightArrow.run(fadeInSequence)
                        self.rightRect.run(fadeInSequence, completion: {() -> Void in
                            self.rightArrow.run(fadeAlpha)
                            self.rightRect.run(fadeAlpha, completion: {() -> Void in
                                // Bottom
                                self.bottomArrow.run(fadeInSequence)
                                self.bottomRect.run(fadeInSequence, completion: {() -> Void in
                                    self.bottomArrow.run(fadeAlpha)
                                    self.bottomRect.run(fadeAlpha, completion: {() -> Void in
                                        // Red Scene
                                        let redScene = RedScene(size: CGSize(width: 750, height: 446))
                                        let moveInTransition = SKTransition.moveIn(with: SKTransitionDirection.right, duration: 1)
                                        
                                        self.view?.presentScene(redScene, transition: moveInTransition)
                                    })
                                })
                            })
                        })
                    })
                })
            })
        })
    }
}
