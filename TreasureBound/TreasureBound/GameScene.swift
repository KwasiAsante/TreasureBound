//
//  GameScene.swift
//  SpaceGame
//
//  Created by Samantha Welch-Fraser on 2019-03-20.
//  Copyright © 2019 TresureBound. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

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
    
    let motionManager = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
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
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.75 + self.xAcceleration * 0.25
            }
        }
        
    }
    
    @objc func addAlien () {
        possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
        let alien = SKSpriteNode(imageNamed: possibleAliens[0])
        
        let randomAlienpostion = GKRandomDistribution(lowestValue: 0, highestValue: 414)
        let position = CGFloat(randomAlienpostion.nextInt())
        
        alien.position = CGPoint(x: position + 200 , y: self.frame.size.height + alien.size.height)
        
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        alien.physicsBody?.contactTestBitMask = photonTorprdoCategory
        alien.physicsBody?.collisionBitMask = 0
        
        self.addChild(alien)
        let animationDuration:TimeInterval = 6
        var actionArray = [SKAction]()
        
        
        actionArray.append(SKAction.move(to: CGPoint(x: position + 100 ,y: -alien.size.height), duration:animationDuration ))
        actionArray.append(SKAction.removeFromParent())
        
        alien.run(SKAction.sequence(actionArray))
        
        
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireTorpedo()
        
    }
    
    
    func fireTorpedo(){
        self.run(SKAction.playSoundFileNamed("torpedo.mp3",waitForCompletion: false))
        
        let torpedoNode = SKSpriteNode(imageNamed: "torpedo")
        torpedoNode.position = player.position
        torpedoNode.position.y += 5
        
        torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width / 2)
        torpedoNode.physicsBody?.isDynamic = true
        torpedoNode.physicsBody?.categoryBitMask = photonTorprdoCategory
        torpedoNode.physicsBody?.contactTestBitMask = alienCategory
        torpedoNode.physicsBody?.collisionBitMask = 0
        torpedoNode.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(torpedoNode)
        //let animationDuration:TimeInterval = 6
        
        
        let animationDuration:TimeInterval = 0.3
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.frame.size.height + 10), duration:animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        torpedoNode.run(SKAction.sequence(actionArray))
        
        
        
        
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & photonTorprdoCategory) != 0 && (secondBody.categoryBitMask & alienCategory) != 0 {
            torpedoDidCollideWithAlien(torpedoNode: firstBody.node as! SKSpriteNode, alienNode: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    
    func torpedoDidCollideWithAlien (torpedoNode:SKSpriteNode, alienNode:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = alienNode.position
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        torpedoNode.removeFromParent()
        alienNode.removeFromParent()
        
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        score += 5
        
        
    }
    
    override func didSimulatePhysics() {
        
        player.position.x += xAcceleration * 50
        
        if player.position.x < -20 {
            player.position = CGPoint(x: self.size.width + 20, y: player.position.y)
        }else if player.position.x > self.size.width + 20 {
            player.position = CGPoint(x: -20, y: player.position.y)
        }
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
