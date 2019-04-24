//
//  EndlessRunnerScene.swift
//  TreasureBound
//
//  Created by Kwasi Asante on 2019-03-13.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class EndlessRunnerMenuScene: SKScene {
    let playButton = SKSpriteNode(imageNamed: "playBTN")
    
    override func didMove(to view: SKView) {
        //Creating PlayButton Menu//
        self.playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY) //PlayButton Position
        self.addChild(self.playButton) //Adding PlayButton node to scene
        self.backgroundColor = UIColor(hex: 0x80D9FF)
        //Create PlayButton Menu END//
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Switch to new scene
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if (self.atPoint(location) == self.playButton){
                let scene = EndlessRunnerScene(size: self.size)
                let view = self.view as! SKView
                view.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                scene.size = view.bounds.size
                view.presentScene(scene)
                
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
