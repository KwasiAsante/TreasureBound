//
//  Helper.swift
//  cars
//
//  Created by Martinez Guillermo on 3/27/19.
//  Copyright © 2019 Martinez Guillermo. All rights reserved.
//

import Foundation
import UIKit

struct ColliderType {
    static let CAR_COLLIDER : UInt32 = 0
    
    static let ITEM_COLLIDER : UInt32 = 1
    
    static let ITEM_COLLIDER_1 : UInt32 = 2
    
}
class Helper : NSObject {
    func randomBetweenTwoNumbers(firstNumber : CGFloat, secondNumber : CGFloat) ->CGFloat{
        return CGFloat(arc4random())/CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber) + min (firstNumber, secondNumber)
 
    
    
    }
    
    
    
}
class Settings {
    static let sharedInstance = Settings()
    
 
      var highScore = 0
}
