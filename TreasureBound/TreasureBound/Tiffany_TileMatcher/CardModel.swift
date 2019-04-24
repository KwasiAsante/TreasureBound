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
        //Array to store numbers that have already generated
        var generatedNumsArray = [Int]()
        
        // Declare array to store generated cards
        var generatedCardsArray = [Card]()
        
        //randomly generate pairs of cards
        while generatedNumsArray.count < 8 {
            //gets random number
            let randNum = arc4random_uniform(13) + 1
        
            if generatedNumsArray.contains(Int(randNum)) == false {
                //logs the number
                print(randNum)
                
                //Stores num into generatedNumsArray
                generatedNumsArray.append(Int(randNum))
                
                //First card obj
                let cardOne = Card()
                cardOne.imgName = "card\(randNum)"
                
                generatedCardsArray.append(cardOne)
                
                //Second card obj
                let cardTwo = Card()
                cardTwo.imgName = "card\(randNum)"
                
                generatedCardsArray.append(cardTwo)
            }            
        }
        
        // randomize card array
        for i in 0...generatedCardsArray.count - 1 {
            //find randomized card to swap with
            let randNum = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
            
            //swap the cards
            let tempStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randNum]
            generatedCardsArray[randNum] = tempStorage
        }
        //return array
        return generatedCardsArray
    }
    
}
