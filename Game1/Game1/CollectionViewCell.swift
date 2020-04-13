//
//  CollectionViewCell.swift
//  Game1
//
//  Created by Temp on 4/10/20.
//  Copyright © 2020 Fabi. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        self.card = card
        
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
            
        }
        else {
            
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
            
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options:[.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        }
        else {
            
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
    }
    
    func flip() {
        
        UIView.transition(from: backImageView, to: frontImageView , duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        
            UIView.transition(from: self.frontImageView, to: self.backImageView , duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
    }
    
    func remove () {
        
        backImageView.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations:{ self.frontImageView.alpha = 0} , completion: nil)
            
        
    }
    
    
}
