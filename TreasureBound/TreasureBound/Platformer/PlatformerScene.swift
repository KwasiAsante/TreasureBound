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
    //Ground Variables//
    let groundBar = SKSpriteNode(imageNamed: "ground") //ground sprite
    var origGroundBarPosX: CGFloat = 0.0 //original ground position
    var maxBarX: CGFloat = 0.0 //ground bar's max width
    var groundSpeed:CGFloat = 5.0 //ground movement speed
    //Ground Variables END//
    
    //Player Variables//
    let player = Player(spriteName: "skipBall") //player sprite
    var playerBaseLine:CGFloat = 0.0 //player base line
    var rotationDegree:CDouble = 0.0 //player rotation degree
    var onGround:Bool = true //is player on the ground
    var velocityY: CGFloat = 0.0 //player y velocity
    let gravity: CGFloat = 0.6 //gravity acting on player
    //Player Variables END//
    
    //Block Variables//
    let squareBlck = SKSpriteNode(imageNamed: "squareBlck") //square block sprite
    let vertBlck = SKSpriteNode(imageNamed: "vertBlck") //vertical block sprite
    var blockStatus:Dictionary<String,BlockStatus> = [:] //Dictionary of block status
    var blockMaxX:CGFloat = 0.0 //max block x position
    var origBlockPosX:CGFloat = 0.0 //original block x position
    //Block Variables END//
    
    //Score Variables//
    var score:Int = 0 //score
    let scoreText = SKLabelNode(fontNamed: "Chalkduster") //score text
    //Score VariableS END//
    
    override func didMove(to view: SKView) {
        print("We are in the new Scene") //Entering new scene test
        
        self.backgroundColor = UIColor(hex: 0x80D9FF) //changing background color to blue
        
        //Creating ground platform//
        self.groundBar.anchorPoint = CGPoint(x: 0, y: 0.5) //changing the ground sprite ancor point to middle left
        self.groundBar.position = CGPoint(x: self.frame.minX,
                                           y: self.frame.minY + (self.groundBar.size.height) / 2) //setting ground poistion
        self.origGroundBarPosX = self.groundBar.position.x //storing the ground's original position
        self.maxBarX = self.groundBar.size.width - self.frame.size.width //setting max ground X to the ground spirte width minus the width of the frame
        self.maxBarX *= -1 //setting max ground x to left side of the screen
        
        self.addChild(self.groundBar) //adding ground node to the scene
        //Creating ground platform END//
        
        //Creating Player//
        self.playerBaseLine = self.groundBar.position.y + (self.groundBar.size.height/2) + (self.player.size.height / 2) //setting the player base line to right on top of ground
        self.player.position = CGPoint(x: self.frame.minX + self.player.size.width + (player.size.width / 4), y: playerBaseLine) //setting player position to the player base line
        
        self.addChild(player) //adding player node to the scene
        //Creating Player END//
        
        //Creating Blocks//
        self.squareBlck.position = CGPoint(x: self.frame.maxX + self.squareBlck.size.width, y: self.playerBaseLine) //setting square block position off screen
        self.squareBlck.name = "sqreB" //giving square block node a name
        blockStatus["sqreB"] = BlockStatus(isRunning: false, timeGapForNextRun: random(), currentInterval: UInt32(0)) //adding sqaure block node to the block status dictionary
        
        self.origBlockPosX = squareBlck.position.x //setting block original position
        
        self.vertBlck.position = CGPoint(x: self.frame.maxX + self.vertBlck.size.width, y: self.playerBaseLine + (self.squareBlck.size.height / 2)) //setting vertical block position off screen
        self.vertBlck.name = "vertB" //giving vertical block node a name
        blockStatus["vertB"] = BlockStatus(isRunning: false, timeGapForNextRun: random(), currentInterval: UInt32(0)) //adding vertical block node to the block satus dictionary
        
        self.blockMaxX = 0 - self.squareBlck.size.width / 2
        
        self.addChild(squareBlck) //adding sqaure block node to the scene
        self.addChild(vertBlck) //adding vertical block node to the scene
        //Creating Blocks END//
        
        //Creating Score//
        self.scoreText.text = "0" //setting score text to 0
        self.scoreText.fontSize = 42 //setting score font size to 42
        self.scoreText.position = CGPoint(x: self.frame.midX, y: self.frame.midY) //setting score text position to the middle of the screen
        
        self.addChild(scoreText) //adding score text node to the scene
        //Creating Score END//
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Endless moving ground platform//
        //If ground position is greater than the max bar x position then...
        if (self.groundBar.position.x <= maxBarX) {
            self.groundBar.position.x = self.origGroundBarPosX //...reset the ground to it's original position
        }
        
        groundBar.position.x -= CGFloat(self.groundSpeed) //Moving the ground based on a fixed speed
        //Endless moving ground platform END//
        
        //Player rotation//
        rotationDegree = CDouble(self.groundSpeed) * Double.pi / 180 //setting rotation degree to the ground speed multipled by pi divided by 180
        self.player.zRotation -= CGFloat(rotationDegree)
        //Player rotation END//
        
        //Player jump//
        self.velocityY += self.gravity //setting to player y velocity to itself plus gravity
        self.player.position.y -= velocityY //updating player position y to the inverse of player y velocity
        //if the player y position becomes less than the player base line then...
        if (self.player.position.y < self.playerBaseLine){
            self.player.position.y = self.playerBaseLine //...set player y position to player base line
            velocityY = 0.0 //setting player y velocity to zero
            self.onGround = true //setting on ground to true
        }
        //Player jump END//
        
        //Block Spawn//
        blockRunner() //block spawner function
        /*for(block, blockStatus) in self.blockStatus {
            if let thisBlock = self.childNode(withName: block) as? SKSpriteNode{
                print ("block has been found")
            }
        }*/
        //Block Spawn END//
    }
    
    func random() -> UInt32 {
        let range = UInt32(50)...UInt32(200) //range between 50 and 200
        print (range.lowerBound + arc4random_uniform(range.upperBound - range.lowerBound+1))
        return range.lowerBound + arc4random_uniform(range.upperBound - range.lowerBound+1) //randomization between range bounds
    }
    
    func blockRunner() {
        
        //for every block in block status
        for(block, blockStatus) in self.blockStatus {
            
            let thisBlock = self.childNode(withName: block) //current block in the dictionary
            
            //if the block status shouldRunBlock is true then...
            if (blockStatus.shouldRunBlock()) {
                blockStatus.timeGapForNextRun = random() //...set the time gap for the next to a random number between 50 and 200
                blockStatus.isRunning = true //setting isrunning to true
            }
            
            //if block staus isrunning is true then...
            if (blockStatus.isRunning){
                //...if the current block x position is greater than the block max x position then...
                if ((thisBlock?.position.x)! > blockMaxX) {
                    thisBlock?.position.x -= CGFloat(self.groundSpeed) //...update current block x position according to ground speed
                //else block position is less then the block max x position then...
                } else {
                    thisBlock?.position.x = self.origBlockPosX //current block returns to original block psoition
                    blockStatus.isRunning = false //set isrunning false
                    self.score += 1 //increcment score by 1
                    //if score is divisable by 5 then...
                    if((self.score % 5) == 0){
                        self.groundSpeed += 1 //...increment ground speed by 1
                    }
                    self.scoreText.text = String(self.score) //upadate scoreText to score
                }
            //else block status isrunning is false then...
            } else {
                blockStatus.currentInterval += 1 //...increment wait interval by 1
            }
        }

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Player Tap Jump///
        //If user touches the screen, check if player is on the ground if so then...
        if (self.onGround){
            self.velocityY = -18.0 //...player y velocity is set to -18.0
            self.onGround = false //and onground is set to false
        }
        //Player Tap Jump END//
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Player Short-Tap Jump//
        //If user does a quick tap on the screen, check if the player y velocity is less than -9.0 if so then..
        if (self.velocityY < -9.0){
            self.velocityY = -9.0 //...set player y velocity to -9.0
        }
        //Player Short-Tap Jump END//
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    
}
