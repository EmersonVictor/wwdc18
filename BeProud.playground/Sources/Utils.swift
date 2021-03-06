import UIKit

// Colors
public struct GrayColors {
    let instruction = UIColor(red:0.11, green:0.11, blue:0.11, alpha:1.0)
    let darker = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
    let dark = UIColor(red:0.32, green:0.32, blue:0.32, alpha:1.0)
    let normal = UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.0)
    let soft = UIColor(red:0.56, green:0.56, blue:0.56, alpha:1.0)
    let light = UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0)
    let lighter = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
}

public struct RainbowColors {
    let red = UIColor(red:0.98, green:0.33, blue:0.33, alpha:1.0)
    let orange = UIColor(red:1.00, green:0.62, blue:0.15, alpha:1.0)
    let yellow = UIColor(red:1.00, green:0.99, blue:0.35, alpha:1.0)
    let green = UIColor(red:0.47, green:0.84, blue:0.44, alpha:1.0)
    let blue = UIColor(red:0.18, green:0.36, blue:0.99, alpha:1.0)
    let purple = UIColor(red:0.58, green:0.15, blue:0.65, alpha:1.0)
}

public let grayColors = GrayColors()
public let rainbowColors = RainbowColors()

// Physics category
public struct PhysicsCategory {
    static let Person: UInt32 = 0b1       // Person
    static let Obstacles: UInt32 = 0b10   // Obstacles
    static let Acceptance: UInt32 = 0b101 // Acceptance
}

// Final texts
public let question = "How important do you think it is to a member of LGBTQ+ accept themselves?"
