//
//  GameScene.swift
//  SpaceGame
//
//  Created by Samantha Welch-Fraser on 2019-03-20.
//  Copyright © 2019 TresureBound. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    
    var  scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet{
            scoreLabel.text = "Score : \(score)"
        }
    }
    
    var gameTimer:Timer!
    var possibleAliens = ["alien", "alien2","alien3"]
    
    let alienCategory:UInt32 = 0x400 << 1
    let photonTorprdoCategory:UInt32 = 0x1 << 0
    
    override func didMove(to view: SKView) {
        starfield = SKEmitterNode(fileNamed: "Starfield" )
        starfield.position = CGPoint(x:300,y:2000)
        
        //advanced simulation bros
        starfield.advanceSimulationTime(20)
        
        self.addChild(starfield)
        
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "shuttle@2x")
        
        player.position = CGPoint(x: self.frame.size.width / 2, y: player.size.height / 2 + 40)
        //player.position = CGPoint(x:0, y:-1*player.size.height/2-500)
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector (dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 200, y: self.frame.size.height - 80)
        
        scoreLabel.fontName = "AmericanTypeWriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        score = 0
        
        self.addChild(scoreLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        
    }
    
    @objc func addAlien () {
        possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
        let alien = SKSpriteNode(imageNamed: possibleAliens[0])
        
        let randomAlienpostion = GKRandomDistribution(lowestValue: 0, highestValue: 414)
        let position = CGFloat(randomAlienpostion.nextInt())
        
        alien.position = CGPoint(x: position, y: self.frame.size.height + alien.size.height)
        
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        alien.physicsBody?.contactTestBitMask = photonTorprdoCategory
        alien.physicsBody?.collisionBitMask = 0
        
        self.addChild(alien)
        
        let animationDuration:TimeInterval = 6
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: position,y: -alien.size.height), duration:animationDuration ))
        actionArray.append(SKAction.removeFromParent())
        
        alien.run(SKAction.sequence(actionArray))
        
        
        
        
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
