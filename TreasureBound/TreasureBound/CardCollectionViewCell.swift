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
        
        //keeps track of card that gets passed in
        self.card = card
        
        frontImgView.image = UIImage(named: card.imgName)
    }
    
    func flip() {
        
        UIView.transition(from: backImgView, to: frontImgView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        
        
    }
}
