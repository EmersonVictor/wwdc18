import UIKit
import PlaygroundSupport


public class FinalView: UIViewController {
    
    let personView = UILabel(frame: CGRect(x: 50, y: 50, width: 90, height: 90))
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupPerson()
        self.paintMe()
    }
    
    func setupPerson() {
        self.personView.backgroundColor = UIColor.white
        self.personView.layer.cornerRadius = 45
        self.personView.clipsToBounds = true
        
        self.view.addSubview(self.personView)
    }
    
    func paintMe() {
        let redRect = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 15))
        redRect.backgroundColor = rainbow.red
        
        let orangeRect = UIView(frame: CGRect(x: 0, y: 15, width: 100, height: 15))
        orangeRect.backgroundColor = rainbow.orange
        
        let yellowRect = UIView(frame: CGRect(x: 0, y: 30, width: 100, height: 15))
        yellowRect.backgroundColor = rainbow.yellow
        
        let greenRect = UIView(frame: CGRect(x: 0, y: 45, width: 100, height: 15))
        greenRect.backgroundColor = rainbow.green
        
        let blueRect = UIView(frame: CGRect(x: 0, y: 60, width: 100, height: 15))
        blueRect.backgroundColor = rainbow.blue
        
        let purpleRect = UIView(frame: CGRect(x: 0, y: 75, width: 100, height: 15))
        purpleRect.backgroundColor = rainbow.purple
        
        self.personView.addSubview(redRect)
        self.personView.addSubview(orangeRect)
        self.personView.addSubview(yellowRect)
        self.personView.addSubview(greenRect)
        self.personView.addSubview(blueRect)
        self.personView.addSubview(purpleRect)
    }
}
