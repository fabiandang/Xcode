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

    @IBOutlet weak var textNameInput: UITextField?
    
    @IBOutlet weak var textEmailInput: UITextField?
    
    @IBOutlet weak var textPasswordInput: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textNameInput?.delegate = self
        textEmailInput?.delegate = self
        textPasswordInput?.delegate = self
        
        self.HideKeyboard()
      
    }
    
    //keyboard return
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        
        textNameInput?.resignFirstResponder()
        textEmailInput?.resignFirstResponder()
        textPasswordInput?.resignFirstResponder()
        
        return true
        
    }
    
}

