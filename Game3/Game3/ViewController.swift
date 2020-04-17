//
//  ViewController.swift
//  Game3
//
//  Created by Temp on 4/16/20.
//  Copyright © 2020 Fabi. All rights reserved.
//

import UIKit


//keyboard dismiss
extension UIViewController {
    func HideKeyboard() {
        
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
               
        view.addGestureRecognizer(Tap)
        
    }
    
    @objc func DismissKeyboard() {
    
        view.endEditing(true)
    }
    
    
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var paddingBottomHeight: NSLayoutConstraint!
    
    @IBOutlet weak var textNameInput: UITextField?
    
    @IBOutlet weak var textEmailInput: UITextField?
    
    @IBOutlet weak var textPasswordInput: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        textNameInput?.layer.borderWidth = 0.5
        textNameInput?.layer.borderColor =  UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1).cgColor
        self.HideKeyboard()
        
        textEmailInput?.layer.borderWidth = 0.5
        textEmailInput?.layer.borderColor =  UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1).cgColor
        self.HideKeyboard()
        
        textPasswordInput?.layer.borderWidth = 0.5
        textPasswordInput?.layer.borderColor =  UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1).cgColor
        
        textNameInput?.delegate = self
        textEmailInput?.delegate = self
        textPasswordInput?.delegate = self
        
        
        
        self.HideKeyboard()
        
        paddingBottomHeight?.constant = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification,  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification,  object: nil)
      
    }
    
    //keyboard return
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            
            paddingBottomHeight.constant = 0
        
        }
            
        else {
            let keyboardFrame: NSValue = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            paddingBottomHeight.constant = keyboardRectangle.height
     
            print(keyboardRectangle.height)
        }
   
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1).cgColor
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1).cgColor
    }
    
   
}

