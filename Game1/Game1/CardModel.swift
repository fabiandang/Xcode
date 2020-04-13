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
        
        var generatedCardArry = [Card]()
        
        for _ in 1...8 {
            
            let randomnumber = Int.random(in: 1...13)
            
            print(randomnumber)
            
            let cardOne = Card()
            cardOne.imageName = "card\(randomnumber)"
            
            generatedCardArry.append(cardOne)
            
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomnumber)"
            
            generatedCardArry.append(cardTwo)
            
            
            
        }
       
        return generatedCardArry
        
    }
    
}
