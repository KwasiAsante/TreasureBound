//
//  GameMenu.swift
//  cars
//
//  Created by Martinez Guillermo on 4/3/19.
//  Copyright © 2019 Martinez Guillermo. All rights reserved.
//

import Foundation
import SpriteKit

class CarsGameMenu: SKScene{
    
    
    var startGame = SKLabelNode()
    var bestScore = SKLabelNode()
    var gameSettings = Settings.sharedInstance
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        startGame = self.childNode(withName: "startGame") as! SKLabelNode
        bestScore = self.childNode(withName: "bestScore") as! SKLabelNode
        bestScore.text = "Best : \(gameSettings.highScore)"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if atPoint(touchLocation).name == "startGame"{
                
                let gameScene = SKScene(fileNamed: "CarGameScene")!
                
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene, transition: SKTransition.doorsCloseHorizontal(withDuration:TimeInterval(2)))
            }
            }
        }
    }
    

