//
//  UIColorExtension.swift
//  TreasureBound
//
//  Created by Kwasi Asante on 2019-04-11.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, aplha: CGFloat = 1.0){
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8 ) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: aplha)
    }
}
