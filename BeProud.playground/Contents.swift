
/*:
 ![Be Proud](BeProudBlackLogo.png)
 
 The purpose of this playground is to metaphorically bring about the self-acceptance of a person from the LGBTQ + community. The circle, in this context, represents a person and at each stage, it becomes happier (colored) and has fewer obstacles to overcome.
 
   The motivation for this came from everything I've been through since I started to discover that I`m a gay boy. All the things I've been through make me what I am today and I hope that you can realize a little of what I wanted to do :)

 ### After all... BE PROUD OF WHO YOU ARE
*/

import PlaygroundSupport
import SpriteKit
import UIKit

// Font
let cfURL = Bundle.main.url(forResource: "BarlowCondensed-Regular", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

// View setup
let introView = IntroView()
introView.preferredContentSize = CGSize(width: 750, height: 446)
PlaygroundSupport.PlaygroundPage.current.liveView = introView


