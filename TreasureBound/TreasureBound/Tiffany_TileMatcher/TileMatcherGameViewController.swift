//
//  GameViewController.swift
//  TreasureBound
//
//  Created by PTz on 2019-03-11.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class TileMatcherGameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var TimerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 30 * 1000 //30 secs

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call getCards method of the card model
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self   
        
        //Create timer
        /*timer = Timer.scheduledTimer(timeInterval: 0.001,
                                     target: self,
                                     selector: #selector(timerElapsed),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)*/
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    //Timer methpods
    @objc func timerElapsed() {
        milliseconds -= 1
        
        //Convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        TimerLabel.text = "Time Remaining: \(seconds)"
        
        //When timer hits zero
        if milliseconds <= 0 {
            //Stops timer at zero
            timer?.invalidate()
            TimerLabel.textColor = UIColor.red
            
            //Check for unmatched cards
            //checkGameEnded()
        }
    }
    
    //UICOllectionVew Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Get card cell obj
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //Get card he collection view is trying to show
        let card = cardArray[indexPath.row]
        
        //Set the card for that cell
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Check for any time left
        if milliseconds <= 0 {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        if card.isFlipped == false && card.isMatched == false {
            
            //Flip card
            cell.flip()
            
            //set card status
            card.isFlipped = true
            
            //Check if its the first card or second card that's flipped
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else {
                //Second card being flipped
                checkForMatches(indexPath)
            }
        }
    } // end of didSelectItemAt
    
    //Game Logic
    func checkForMatches(_ secondFlippedCardIndex:IndexPath) {
        //Get cells for the two cards thqt were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
    
        //Gets cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //Comparing the two cards
        if cardOne.imgName == cardTwo.imgName {
            //It's a match
            
            //Set states of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //Remove cards from grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //Check if any cards are unmatched
            checkGameEnded()
        }
        else {
            //It's not a match
            
            //Set statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            //Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        //Tell collection view to reload cell if it's nil
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        //Reset the property that keeps track of the first flipped card
        firstFlippedCardIndex = nil
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func checkGameEnded() {
        //See if any cards are unmatched
        var isWon = true
        
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        
        //End of game messages
        var title = ""
        var message = ""
        
        //If none are left the player wins
        if isWon == true {
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Congrats!"
            message = "You won!"
        }
        else {
            //if there are still unmatched cards, check to see if there's time left
            if milliseconds > 0 {
                return
            }
            
            title = "Too bad"
            message = "You lost :("
        }
        
        //Win/Lose message
        ShowAlert(title, message)
    }
    
    //Shows the winning or losing messages
    func ShowAlert(_ title:String, _ message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
