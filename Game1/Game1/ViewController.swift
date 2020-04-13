//
//  ViewController.swift
//  Game1
//
//  Created by Temp on 4/10/20.
//  Copyright © 2020 Fabi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCard:IndexPath?
    
    var timer:Timer?
    
    var milliseconds:Float = 20 * 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardArray = model.getCard()
        collectionView.delegate = self
        collectionView.dataSource = self
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
       
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func timerElapsed() {
        
        milliseconds -= 1
        
        let seconds = String(format: "%.2f", milliseconds/1000)
    
        timeLabel.text = "Time Remaining : \(seconds)"
        
        if milliseconds <= 0 {
            
            timer?.invalidate()
            
            timeLabel.textColor = UIColor.red
            
            checkGameEnded()
            
            
        }
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
        
        if milliseconds <= 0 {
            
            return
            
        }
        
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
            
            //kiem tra con card ??
            
            checkGameEnded()
            
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
    
    func checkGameEnded() {
        
        var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false {
                
                isWon = false
                break
                
            }
            
        }
        
        var title = ""
        var message = ""
        
        if isWon == true {
            
            if milliseconds > 0 {
                
                timer?.invalidate()
                
            }
            title = "Congratulations"
            message = "You've won"
        }
        else {
            
            if milliseconds > 0 {
                
                return
                
            }
            
            title = "Game Over"
            message = "You've lost"
            
        }
        
        showAlert(title,message)
    }
    
    func showAlert(_ title:String,_ message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true , completion: nil)
    }
    
}

