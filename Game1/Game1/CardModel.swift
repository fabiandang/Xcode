//
//  CardModel.swift
//  Game1
//
//  Created by Temp on 4/10/20.
//  Copyright © 2020 Fabi. All rights reserved.
//

import Foundation
import UIKit

class CardModel {
    
    func getCard() -> [Card] {
        
        var generatedNumberArray = [Int]()
        
        var generatedCardArry = [Card]()
        
        while generatedNumberArray.count < 8 {
            
            let randomnumber = Int.random(in: 1...13)
            
            if generatedNumberArray.contains(randomnumber) == false {
            
                generatedNumberArray.append(randomnumber)
                
                let cardOne = Card()
                cardOne.imageName = "card\(randomnumber)"
                
                generatedCardArry.append(cardOne)
                
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomnumber)"
                
                generatedCardArry.append(cardTwo)
                
                
            }
            
        }
       
        for i in 0...generatedCardArry.count-1 {
            
            let randomnumber = Int.random(in: 0...generatedCardArry.count-1)
            
            let temporaryStorage = generatedCardArry[i]
            
            generatedCardArry[i] = generatedCardArry[randomnumber]
            generatedCardArry[randomnumber] = temporaryStorage
            
            
        }
        
        return generatedCardArry
        
    }
    
}
