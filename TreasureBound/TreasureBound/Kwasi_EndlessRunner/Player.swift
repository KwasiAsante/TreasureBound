//
//  Player.swift
//  TreasureBound
//
//  Created by Kwasi Asante on 2019-03-13.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    init(spriteName: String?) {
        let texture = SKTexture(imageNamed: spriteName!)
        super.init(texture: texture , color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError  ("init(coder:) has not been implemented")
    }
}
