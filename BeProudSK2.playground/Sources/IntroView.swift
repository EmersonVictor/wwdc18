import UIKit
import PlaygroundSupport
import SpriteKit

public class IntroView: UIViewController {
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
        
        UIView.animate(withDuration: 10, delay: 1, options:[UIViewAnimationOptions.repeat, UIViewAnimationOptions.autoreverse], animations: {
            tryButton.layer.borderColor = rainbowColors.red.cgColor
            tryButton.layer.borderColor = rainbowColors.orange.cgColor
            tryButton.layer.borderColor = rainbowColors.yellow.cgColor
            tryButton.layer.borderColor = rainbowColors.green.cgColor
            tryButton.layer.borderColor = rainbowColors.blue.cgColor
            tryButton.layer.borderColor = rainbowColors.purple.cgColor
        }, completion: nil)
        
        self.view.addSubview(tryButton)
    }
    
    @objc func started() {
        let redView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 540))
        let redScene = RedScene(size: CGSize(width: 750, height: 540))
        
        redView.presentScene(redScene)
        PlaygroundPage.current.liveView = redView
    }
}
