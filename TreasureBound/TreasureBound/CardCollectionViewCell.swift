//
//  CardCollectionViewCell.swift
//  TreasureBound
//
//  Created by Hull Tiffany C. on 4/4/19.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontImgView: UIImageView!
    
    @IBOutlet weak var backImgView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        //Keeps track of card that gets passed in
        self.card = card
        
        if card.isMatched == true {
            //If card has been matched, make img views invisible
            backImgView.alpha = 0
            frontImgView.alpha = 0
            
            return
        }
        else {
            //If card hasn't been matched, keep img views visible
            backImgView.alpha = 1
            frontImgView.alpha = 1
        }
        
        frontImgView.image = UIImage(named: card.imgName)
        
        //Finds out if card is flipped face up or face down
        if card.isFlipped == true {
            UIView.transition(from: backImgView,
                              to: frontImgView,
                              duration: 0,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
            
        }
        else {
            UIView.transition(from: frontImgView,
                              to: backImgView,
                              duration: 0,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
        }
    }
    
    //Flips card from back to front
    func flip() {
        
        UIView.transition(from: backImgView,
                          to: frontImgView,
                          duration: 0.3,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews],
                          completion: nil)
    }
    
    //Flips card from front to back
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        
        UIView.transition(from: self.frontImgView,
                          to: self.backImgView,
                          duration: 0.3,
                          options: [.transitionFlipFromRight, .showHideTransitionViews],
                          completion: nil)
        }
    }
    
    func remove() {
        //Removes both img views from being visible
        
        //Animation
        UIView.animate(withDuration: 0.4, delay: 0.5,
                       options: .curveEaseOut,
                       animations: {self.frontImgView.alpha = 0},
                       completion: nil)
    }
    
}
