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

class PuzzleViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var gameViewWidth : CGFloat!
    var blockWidth : CGFloat!
    
    var xCen : CGFloat!
    var yCen : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Determinging the size of the game view and the blocks
        gameViewWidth = gameView.frame.size.width
        blockWidth = gameViewWidth / 4
        
        xCen = blockWidth / 2
        yCen = blockWidth / 2
        
        //Placeing the blocks in a 4X4 grid
        //4 rows
        for v in 0..<4
        {
            
            //4 columns
            for h in 0..<4 {
        
                let blockFrame : CGRect = CGRect(x: 0, y: 0, width: blockWidth - 4, height: blockWidth - 4)
                let block: UILabel = UILabel(frame: blockFrame)
            
                block.center = CGPoint(x: xCen, y: yCen)
            
                block.backgroundColor = UIColor.lightGray
                gameView.addSubview(block)
            
                xCen = xCen + blockWidth
            
            }
            
            //Reseting x center and increasing the y center
            xCen = blockWidth / 2
            yCen = yCen + blockWidth
        }
    }
    
    
    @IBAction func resetAction(_ sender: Any) {
    }
    
}
