import UIKit
import PlaygroundSupport
import SpriteKit

public class IntroView: UIViewController {
    var count = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTryButton()
        self.addLogo()
    }
    
    func addLogo() {
        let logo = UIImage(named: "BeProudLogo")
        let logoView = UIImageView(image: logo)
        logoView.frame.origin.x = self.view.frame.size.width/2 - (logo?.size.width)!/2
        logoView.frame.origin.y = 130
        
        self.view.addSubview(logoView)
    }
    
    func setupTryButton() {
        let tryButton = UIButton(frame: CGRect(x: self.view.frame.size.width/2 - 95, y: 330, width: 190, height: 65))
        tryButton.setTitle("TRY!", for: UIControlState.normal)
        tryButton.titleLabel?.textColor = UIColor.white
        tryButton.titleLabel?.font = UIFont(name: "BarlowCondensed-Regular", size:  33)
        tryButton.layer.borderWidth = 1.5
        tryButton.layer.borderColor = UIColor.white.cgColor
        tryButton.addTarget(self, action: #selector(IntroView.started), for: UIControlEvents.touchUpInside)
        
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) -> Void in
            UIView.animate(withDuration: 0.5, animations: {
                
                switch self.count {
                case 0:
                    tryButton.layer.borderColor = rainbowColors.red.cgColor
                case 1:
                    tryButton.layer.borderColor = rainbowColors.orange.cgColor
                case 2:
                    tryButton.layer.borderColor = rainbowColors.yellow.cgColor
                case 3:
                    tryButton.layer.borderColor = rainbowColors.green.cgColor
                case 4:
                    tryButton.layer.borderColor = rainbowColors.blue.cgColor
                case 5:
                    tryButton.layer.borderColor = rainbowColors.purple.cgColor
                default:
                    tryButton.layer.borderColor = UIColor.white.cgColor
                }
                
                self.count += 1
                if self.count > 5 {
                    self.count = 0
                }
            })
        }
        
        self.view.addSubview(tryButton)
    }
    
    @objc func started() {
        let redView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 540))
        let redScene = RedScene(size: CGSize(width: 750, height: 540))
        
        redView.presentScene(redScene)
        PlaygroundPage.current.liveView = redView
    }
}
