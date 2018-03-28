// Be proud
import UIKit
import PlaygroundSupport



public class RedView: UIViewController {
    
    let personView = UIView(frame: CGRect(x: 50, y: 50, width: 90, height: 90))
    let acceptanceView = UILabel(frame: CGRect(x: 610, y: 205, width: 40, height: 40))
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = grayScale.darker
        self.setupPerson()
        self.setupAcceptance()
        self.setupNextButton()
        self.createObstacles()
    }
    
    func setupPerson() {
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector (RedView.wasDragged(_:)))
        self.personView.addGestureRecognizer(dragGesture)
        self.personView.isUserInteractionEnabled = true
        self.personView.backgroundColor = UIColor.white
        self.personView.layer.cornerRadius = 45
        self.personView.clipsToBounds = true
        self.view.addSubview(self.personView)
    }
    
    func setupAcceptance() {
        self.acceptanceView.backgroundColor = rainbow.red
        self.acceptanceView.layer.cornerRadius = 45
        self.acceptanceView.clipsToBounds = true
        self.view.addSubview(self.acceptanceView)
    }
    
    func setupNextButton() {
        let nextButton = UIButton(frame: CGRect(x: 610, y: 395, width: 50, height: 20))
        nextButton.setTitle("NEXT >", for: UIControlState.normal)
        nextButton.titleLabel?.textColor = UIColor.white
        nextButton.titleLabel?.font = UIFont(name: "BarlowCondensed-Regular", size:  20)
        nextButton.addTarget(self, action: #selector(RedView.tapToNext), for: UIControlEvents.touchUpInside)
        self.view.addSubview(nextButton)
    }
    
    func createObstacles() {
        var wall: UIView
        
        wall = UIView(frame: CGRect(x: 630, y: 380, width: 105, height: 8))
        wall.backgroundColor = UIColor.black
        
        self.view.addSubview(wall)
    }
    
    @objc func wasDragged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        if let label = gesture.view {
            
            let centerX = label.center.x + translation.x
            let centerY = label.center.y + translation.y
            

            
            if centerY > 45 && centerY < 405  {
                label.center = CGPoint(x: label.center.x, y: label.center.y + translation.y)
            }
            
            if  centerX > 45 && centerX < 655 {
                label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y)
            }
            
            
            
            

            
            
            //label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    @objc func tapToNext() {
        let orangeView = OrangeView()
        orangeView.preferredContentSize = CGSize(width: 700, height: 450)
        self.present(orangeView, animated: true)
    }
}



// Start View
let startView = RedView()
startView.preferredContentSize = CGSize(width: 700, height: 450)

PlaygroundPage.current.liveView = startView


