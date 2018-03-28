import UIKit
import PlaygroundSupport

public class IntroView: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Try button
        let tryButton = UIButton(frame: CGRect(x: 255, y: 300, width: 190, height: 65))
        tryButton.setTitle("TRY!", for: UIControlState.normal)
        tryButton.titleLabel?.textColor = UIColor.white
        tryButton.titleLabel?.font = UIFont(name: "BarlowCondensed-Regular", size:  33)
        tryButton.layer.borderWidth = 1.5
        tryButton.layer.borderColor = UIColor.white.cgColor
        tryButton.addTarget(self, action: #selector(StartView.started), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(tryButton)
    }
    
    @objc func started() {
        let redView = RedView()
        redView.preferredContentSize = CGSize(width: 700, height: 450)
        self.present(redView, animated: true)
    }
}

