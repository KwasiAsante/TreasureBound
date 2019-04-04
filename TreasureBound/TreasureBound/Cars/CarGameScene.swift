//
//  CarGameScene.swift
//   guillermo martinez cars
//
//  Created by Martinez Guillermo on 3/13/19.
//  Copyright © 2019 Martinez Guillermo. All rights reserved.
//

import SpriteKit
import GameplayKit

class CarGameScene: SKScene,SKPhysicsContactDelegate {
    
    var leftCar = SKSpriteNode()
    var rightCar = SKSpriteNode()
    
    var canMove = false
    var leftToMoveLeft = true
    var rightCarToMoveRight = true
    
    var leftCarAtRight = false
    var rightCarAtLeft = false
    //var centerPoint : CGFloat!
    var centerPoint : CGFloat!
    var score = 0
    
    //max to move left to right
    
    let leftCarMinimumX :CGFloat = -280
    let leftCarMaximumX :CGFloat = -100
    
     let rightCarMinimumX :CGFloat = 100
     let rightCarMaximumX :CGFloat = 280
    
    //score/ countdown / label n settings
    var countDown = 1
    var stopEverything = true
    var scoreText = SKLabelNode()
    var gameSettings = Settings.sharedInstance
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        setUp()
        physicsWorld.contactDelegate = self
        
        
       // createRoadStrip()
        Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(CarGameScene.createRoadStrip), userInfo: nil,  repeats: true)
        //countdown
        Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(CarGameScene.startCountDown), userInfo: nil, repeats: true)
        //traffic left
        Timer.scheduledTimer(timeInterval: TimeInterval(Helper().randomBetweenTwoNumbers(firstNumber: 0.5, secondNumber: 1.8)), target: self, selector: #selector(CarGameScene.leftTraffic), userInfo: nil,  repeats: true)
        
        //right traffic
          Timer.scheduledTimer(timeInterval: TimeInterval(Helper().randomBetweenTwoNumbers(firstNumber: 0, secondNumber: 1.8)), target: self, selector: #selector(CarGameScene.rightTraffic), userInfo: nil,  repeats: true)
        
        //remove cars from spwaning alot
        Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(CarGameScene.removeItems), userInfo: nil,  repeats: true)
        
        //score + time
        let deadTime = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: deadTime) {
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(CarGameScene.increaseScore), userInfo: nil, repeats: true)
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        if canMove{
            move(leftSide: leftToMoveLeft)
            moveRightCar(rightSide: rightCarToMoveRight)
        }
        showRoadStrip()
    }
    func didBegin(_ contact: SKPhysicsContact)
    {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "leftCar" || contact.bodyA.node?.name == "rightCar" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            
        }
        firstBody.node?.removeFromParent()
        secondBody.node?.removeFromParent()
        afterCollision()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if touchLocation.x > centerPoint{
                if rightCarAtLeft{
                rightCarAtLeft = false
                rightCarToMoveRight = true
                    
        }else{
                 rightCarAtLeft = true
                 rightCarToMoveRight = false
            }
        }else{
                if leftCarAtRight{
                   leftCarAtRight = false
                   leftToMoveLeft = true
                    
                }else{
                    leftCarAtRight = true
                    leftToMoveLeft  = false
                }
            }
            canMove = true
            //11:58 last worked on
        }
    }
    func setUp(){
        
        leftCar = self.childNode(withName: "leftCar") as! SKSpriteNode
        rightCar = self.childNode(withName: "rightCar") as! SKSpriteNode
        centerPoint = self.frame.size.width / self.frame.size.height
        
        //left car collison
        leftCar.physicsBody?.categoryBitMask = ColliderType.CAR_COLLIDER
        leftCar.physicsBody?.contactTestBitMask = ColliderType.ITEM_COLLIDER
        leftCar.physicsBody?.collisionBitMask = 0
        
        //right car collsion
        rightCar.physicsBody?.categoryBitMask = ColliderType.CAR_COLLIDER
        rightCar.physicsBody?.contactTestBitMask = ColliderType.ITEM_COLLIDER_1
        rightCar.physicsBody?.collisionBitMask = 0
        
        let scoreBackGround = SKShapeNode(rect:CGRect(x:-self.size.width/2 + 70 ,y:self.size.height/2 - 130 ,width:180,height:80), cornerRadius: 20)
        scoreBackGround.zPosition = 4
        scoreBackGround.fillColor = SKColor.black.withAlphaComponent(0.3)
        scoreBackGround.strokeColor = SKColor.black.withAlphaComponent(0.3)
        addChild(scoreBackGround)
        
        scoreText.name = "score"
            scoreText.fontName = "AvenirNext"
        
        scoreText.text = "0"
            scoreText.fontColor = SKColor.white
        scoreText.position = CGPoint(x: -self.size.width/2 + 160, y: self.size.height/2 - 110)
            scoreText.fontSize = 50
        scoreText.zPosition = 4
        //display score and size n area / border around
        addChild(scoreText)
    }
    @objc func createRoadStrip(){
        
        // left road stripe
        let leftRoadStrip = SKShapeNode(rectOf : CGSize(width: 10, height: 40))
        leftRoadStrip.strokeColor = SKColor.white
        leftRoadStrip.fillColor = SKColor.white
        leftRoadStrip.alpha = 0.4
        leftRoadStrip.name = "leftRoadStrip"
        leftRoadStrip.zPosition = 10
        leftRoadStrip.position.x = -187.5
        leftRoadStrip.position.y = 700
        addChild(leftRoadStrip)
        
        //right road stripe
        let rightRoadStrip = SKShapeNode(rectOf : CGSize(width: 10, height: 40))
        rightRoadStrip.strokeColor = SKColor.white
        rightRoadStrip.fillColor = SKColor.white
        rightRoadStrip.alpha = 0.4
        rightRoadStrip.name = "rightRoadStrip"
        rightRoadStrip.zPosition = 10
        rightRoadStrip.position.x = 187.5
        rightRoadStrip.position.y = 700
        addChild(rightRoadStrip)
        
}
    
    
    func showRoadStrip(){
        enumerateChildNodes(withName: "leftRoadStrip", using:{ (roadStrip,stop) in
                let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        })
        
        enumerateChildNodes(withName: "rightRoadStrip", using:{ (roadStrip,stop) in
            let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        })
        enumerateChildNodes(withName: "orangeCar", using:{ (leftCar,stop) in
            let car = leftCar as! SKSpriteNode
            car.position.y -= 15
        })
        enumerateChildNodes(withName: "blueCar", using:{ (rightCar,stop) in
            let car = rightCar as! SKSpriteNode
            car.position.y -= 15
        })
}
    @objc func removeItems (){
        for child in children{
            if child.position.y < -self.size.height - 100{
                child.removeFromParent()
            }
        }
    }
    func move(leftSide:Bool)
    {
        if leftSide{
        leftCar.position.x -= 20
            if leftCar.position.x < leftCarMinimumX{
                leftCar.position.x = leftCarMinimumX
            }
        }else{
        leftCar.position.x += 20
        
            if leftCar.position.x > leftCarMaximumX{
                leftCar.position.x = leftCarMaximumX
    
            }
        }
    }
    func moveRightCar(rightSide:Bool){
        if rightSide{
           rightCar.position.x += 20
            if rightCar.position.x > rightCarMaximumX{
                rightCar.position.x = rightCarMaximumX
        }
        }else{
            rightCar.position.x -= 20
            if rightCar.position.x < rightCarMinimumX{
                rightCar.position.x = rightCarMinimumX
        }
    }
 }
    
    //random for left traffic
    @objc func leftTraffic(){
        
          if !stopEverything{
        let leftTrafficitem : SKSpriteNode
        let randomNumber = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 8)
        switch Int(randomNumber) {
        case 1...4:
            leftTrafficitem = SKSpriteNode (imageNamed: "orangeCar")
            leftTrafficitem.name = "orangeCar"
            break
        case 5...8:
            leftTrafficitem = SKSpriteNode(imageNamed: "blueCar")
            leftTrafficitem.name = "blueCar"
            break
        default:
            leftTrafficitem = SKSpriteNode (imageNamed: "orangeCar")
            leftTrafficitem.name = "orangeCar"
            
        }
        leftTrafficitem.anchorPoint = CGPoint( x: 0.5,y: 0.5)
        leftTrafficitem.zPosition = 10
        let randomNum = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 10)
        switch Int(randomNum) {
        case 1...4:
            leftTrafficitem.position.x = -280
            break
        case 5...10:
             leftTrafficitem.position.x = -100
        default:
              leftTrafficitem.position.x = -280
        }
        leftTrafficitem.position.y = 700
        
        
        leftTrafficitem.physicsBody = SKPhysicsBody(circleOfRadius: leftTrafficitem.size.height/2)
        leftTrafficitem.physicsBody?.categoryBitMask = ColliderType.ITEM_COLLIDER
        leftTrafficitem.physicsBody?.collisionBitMask = 0
        leftTrafficitem.physicsBody?.affectedByGravity = false
        
        addChild(leftTrafficitem)
        }
    }
    
    
    @objc func rightTraffic(){
       if !stopEverything{
        let rightTrafficitem : SKSpriteNode
        let randomNumber = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 8)
        switch Int(randomNumber) {
        case 1...4:
            rightTrafficitem = SKSpriteNode (imageNamed: "orangeCar")
            rightTrafficitem.name = "orangeCar"
            break
        case 5...8:
            rightTrafficitem = SKSpriteNode(imageNamed: "blueCar")
            rightTrafficitem.name = "blueCar"
            break
        default:
            rightTrafficitem = SKSpriteNode (imageNamed: "orangeCar")
            rightTrafficitem.name = "orangeCar"
            
        }
        rightTrafficitem.anchorPoint = CGPoint( x: 0.5,y: 0.5)
        rightTrafficitem.zPosition = 10
        let randomNum = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 10)
        switch Int(randomNum) {
        case 1...4:
            rightTrafficitem.position.x = 280
            break
        case 5...10:
            rightTrafficitem.position.x = 100
        default:
            rightTrafficitem.position.x = 280
        }
        rightTrafficitem.position.y = 700
        
        
        rightTrafficitem.physicsBody = SKPhysicsBody(circleOfRadius: rightTrafficitem.size.height/2)
        rightTrafficitem.physicsBody?.categoryBitMask = ColliderType.ITEM_COLLIDER_1
        rightTrafficitem.physicsBody?.collisionBitMask = 0
        rightTrafficitem.physicsBody?.affectedByGravity = false
        
        addChild(rightTrafficitem)
        }}

    func afterCollision(){
        
        
        if gameSettings.highScore < score{
            gameSettings.highScore = score
        }
        let menuScene = SKScene(fileNamed: "GameMenu")!
        menuScene.scaleMode = .aspectFill
        view?.presentScene(menuScene, transition: SKTransition.doorsCloseHorizontal(withDuration: TimeInterval(2)))
    }
    
    @objc func startCountDown(){
        if countDown>0{
            if countDown < 4{
            let countDownLabel = SKLabelNode()
            countDownLabel.fontName = "AvenirNext"
            countDownLabel.fontColor = SKColor.white
            countDownLabel.fontSize = 300
            countDownLabel.text = String(countDown)
            
                countDownLabel.position = CGPoint(x: 0, y: 0)
            countDownLabel.zPosition = 300
                countDownLabel.name = "cLabel"
                countDownLabel.horizontalAlignmentMode = .center
                addChild(countDownLabel)
                
                let deadTime = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: deadTime, execute: {
                    countDownLabel.removeFromParent()
                })
            }
            countDown += 1
            if countDown == 4 {
                self.stopEverything = false
            }
        }
    }
    
    @objc func increaseScore(){
        if !stopEverything{
            score += 1
            scoreText.text = String(score)
        }
}
}


