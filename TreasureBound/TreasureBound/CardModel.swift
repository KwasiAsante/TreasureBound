//
//  CardModel.swift
//  TreasureBound
//
//  Created by Hull Tiffany C. on 4/4/19.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        // Declare array to store generated cards
        var generatedCardsArray = [Card]()
        
        //randomly generate pairs of cards
        for _ in 1...8 {
            //gets random number
            let randNum = arc4random_uniform(13) + 1
        
            //logs the number
            print(randNum)
            
            //First card obj
            let cardOne = Card()
            cardOne.imgName = "card\(randNum)"
            
            generatedCardsArray.append(cardOne)
            
            //Second card obj
            let cardTwo = Card()
            cardTwo.imgName = "card\(randNum)"
            
            generatedCardsArray.append(cardTwo)
            //unique pairs of cards
        }
        
        //todo: randomize array
        
        //return array
        return generatedCardsArray
    }
    
}
