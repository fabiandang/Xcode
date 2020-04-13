//
//  ViewController.swift
//  Game1
//
//  Created by Temp on 4/10/20.
//  Copyright © 2020 Fabi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {


    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCard:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardArray = model.getCard()
        collectionView.delegate = self
        collectionView.dataSource = self
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CollectionViewCell
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
        
            cell.flip()
            card.isFlipped = true
            
            if firstFlippedCard == nil {
                
                firstFlippedCard = indexPath
                
            }
            else {
                
                 checkForMachtes(indexPath)
                
            }
        }
        else {
            
            cell.flipBack()
            card.isFlipped = false
        }
        
        
    }
    
    func checkForMachtes(_ secondFlippedCardIndex:IndexPath) {
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCard!) as? CollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CollectionViewCell
        
        let cardOne = cardArray[firstFlippedCard!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName {
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        }
        else {
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
        }
        
        if cardOneCell == nil {
            
            collectionView.reloadItems(at: [firstFlippedCard!])
            
        }
        firstFlippedCard = nil
    
    }
    
}

