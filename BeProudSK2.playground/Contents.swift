import PlaygroundSupport
import SpriteKit
import UIKit

// Font
let cfURL = Bundle.main.url(forResource: "BarlowCondensed-Regular", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)


// View setup
let introView = IntroView()
introView.preferredContentSize = CGSize(width: 750, height: 540)
PlaygroundSupport.PlaygroundPage.current.liveView = introView


