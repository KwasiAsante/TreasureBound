//
//  PuzzleSwipeViewController.swift
//  TreasureBound
//
//  Created by PTz on 2019-03-19.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class PuzzleSwipeViewController: UIViewController {
<<<<<<< HEAD

    @IBOutlet weak var gameView: UIView!

=======
    
    @IBOutlet weak var gameView: UIView!
    
>>>>>>> f7ec64db7915b2b6576844d0f017cf64c0cc66c9
    @IBOutlet weak var timerLabel: UILabel!
    
    var gameViewWidth : CGFloat!
    var blockWidth : CGFloat!
    
    var xCen : CGFloat!
    var yCen : CGFloat!
    
    var blocksArr: NSMutableArray = []
    var centerArr: NSMutableArray = []
    
    var timeCount: Int = 0
    var gameTimer: Timer = Timer()
    
    var empty: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBlocks()
        //randomizeAction()
        
        self.resetAction(Any.self)
    }
    
    
    //Block spawner
    func makeBlocks () {
        
        //Clear array
        blocksArr = []
        centerArr = []
        
        //Determinging the size of the game view and the blocks
        gameViewWidth = gameView.frame.size.width
        blockWidth = gameViewWidth / 4
        
        xCen = blockWidth / 2
        yCen = blockWidth / 2
        
        
        //Tracking the blocks
        var labelNum : Int = 1
        
        //Placeing the blocks in a 4X4 grid
        //4 rows
        for _ in 0..<4
        {
            
            //4 columns
            for _ in 0..<4 {
        
                let blockFrame : CGRect = CGRect(x: 0, y: 0, width: blockWidth - 4, height: blockWidth - 4)
                let block: MyLabel = MyLabel(frame: blockFrame)
                
                //Add user interaction
                block.isUserInteractionEnabled = true
                
                //Allows player touch
                block.isUserInteractionEnabled = true
            
                let thisCen: CGPoint = CGPoint(x: xCen, y: yCen)
                block.center = thisCen
                block.OrigCen = thisCen
                
                centerArr.add(thisCen)
                
                //Block text
                block.text = String(labelNum)
                block.textAlignment = NSTextAlignment.center
                block.font = UIFont.systemFont(ofSize: 24)
                
                labelNum += 1
            
                block.backgroundColor = UIColor.lightGray
                gameView.addSubview(block)
                
                blocksArr.add(block)
            
                xCen = xCen + blockWidth
            
            }
            
            //Reseting x center and increasing the y center
            xCen = blockWidth / 2
            yCen = yCen + blockWidth
        }
        
        //Removing the last block
        let lastBlock : MyLabel = blocksArr[15] as! MyLabel
        lastBlock.removeFromSuperview()
        blocksArr.removeObject(at: 15)
    }
    
    //Randomize block locations
    func randomizeAction(){
        
        let tempCentersArr : NSMutableArray = centerArr.mutableCopy() as! NSMutableArray
        
        for anyBlock in blocksArr {
            let randomIndex : Int = Int(arc4random()) % tempCentersArr.count
            let randomCenter : CGPoint = tempCentersArr[randomIndex] as! CGPoint
            
            (anyBlock as! MyLabel).center = randomCenter
            
            (anyBlock as! MyLabel).backgroundColor = UIColor.lightGray;
            
            //Remove the center from the array
            tempCentersArr.removeObject(at: randomIndex)
        }
        
        empty = tempCentersArr[0] as! CGPoint
    }
    
    //Restart button
    @IBAction func resetAction(_ sender: Any) {
        
        randomizeAction()
        
        timeCount = 0
        gameTimer.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self, selector: #selector(timerAction),
                                         userInfo: nil, repeats: true)
        
    }
    
    //Timer action
    @objc func timerAction() {
        timeCount += 1
        timerLabel.text = String.init(format: "%02d", timeCount)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myTouch : UITouch = touches.first!
        
        if(blocksArr.contains(myTouch.view as Any)){
            
            let touchView: MyLabel = (myTouch.view)! as! MyLabel
            
            let xDif: CGFloat = touchView.center.x - empty.x
            let yDif: CGFloat = touchView.center.y - empty.y
            
            let distance : CGFloat = sqrt(pow(xDif, 2) + pow(yDif, 2))
            
            
            // moving the tiles
            
            if(distance == blockWidth){
                let tempCen : CGPoint = touchView.center
                
                //movement animations
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.2)
                touchView.center = empty
                UIView.commitAnimations()
                
                if(touchView.OrigCen == empty){
                    touchView.backgroundColor = UIColor.blue
                }
                else{
                    touchView.backgroundColor = UIColor.lightGray
                }
                
                empty = tempCen
            }
        }
    }
    
    
    
}



//Custom label class for blocks
class MyLabel: UILabel {
    var OrigCen: CGPoint!
}
