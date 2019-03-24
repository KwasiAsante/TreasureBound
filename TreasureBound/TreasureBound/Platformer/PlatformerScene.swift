//
//  PlatformerScene.swift
//  TreasureBound
//
//  Created by Kwasi Asante on 2019-03-13.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlatformerScene: SKScene {
    let player = Player(spriteName: "adventurer-idle-0")
    
    override func didMove(to view: SKView) {
        //Background Setup//
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "Clouds_Loopable_100x59")
        background.size = self.size
        background.position = CGPoint(x: 0, y: 0)
        addChild(background)
        
        //Player Setup//
        player.size = CGSize(width: player.size.width*2, height: player.size.height*2)
        player.position = CGPoint(x: -320, y: -160)
        player.zPosition = 1
        addChild(player)
        
        addSwipeGestureRecognizer()
    }
    
    func addSwipeGestureRecognizer(){
        let gestureDirections: [UISwipeGestureRecognizer.Direction] = [.up, .down, .right, .left]
        for gestureDirect in gestureDirections{
            let gestureRecognizer = UISwipeGestureRecognizer (target: self, action: #selector(handleSwipe))
            gestureRecognizer.direction = gestureDirect
            self.view?.addGestureRecognizer(gestureRecognizer )
        }
    }
    
    @objc func handleSwipe(gesture: UIGestureRecognizer){
        if let gesture = gesture as?  UISwipeGestureRecognizer {
            switch gesture.direction{
            case .up:
                print ("Swiped Up")
            case .down:
                print ("Swiped Down")
            case .left:
                print ("Swiped Left")
            case .right:
                print ("Swiped Right")
            default:
                print ("No such gesture")
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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