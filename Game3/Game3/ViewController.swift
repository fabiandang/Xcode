//
//  ViewController.swift
//  Game3
//
//  Created by Temp on 4/16/20.
//  Copyright © 2020 Fabi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var paddingBottomHeight : NSLayoutConstraint!
    @IBOutlet weak private var textNameInput       : CustomTextField!
    @IBOutlet weak private var textEmailInput      : CustomTextField!
    @IBOutlet weak private var textPasswordInput   : CustomTextField!
    
    // MARK: ViewController lifecycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("--------------------------------")
        print("👍👍👍👍 0 [DEBUG] \(self) init")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("✂️✂️✂️✂️ 1 [DEBUG] \(self) viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("✂️✂️✂️✂️ 2 [DEBUG] \(self) viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("✂️✂️✂️✂️ 3 [DEBUG] \(self) viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("✂️✂️✂️✂️ 4 [DEBUG] \(self) viewDidDisappear")
    }
    
    // This is destructor
    // If called after this class is detroyed.
    deinit {
        print("👍👍👍👍 5 [DEBUG] \(self) deinit")
        removeNotifications()
    }
    
    // MARK: - Private function
    private func setup() {
        // Setup CustomTextField's style
        
        // This `textNameInput` is NULL on signup screen
        // Let check its pointer
        //
        // MARK: You can use:
        /*
        if textNameInput != nil {
            textNameInput.setAsDefault()
        }
        */
        // MARK: OR
        if let unNULL_textNameInput = textNameInput {
            unNULL_textNameInput.setAsDefault()
        }
        //
        
        textEmailInput.setAsDefault()
        textPasswordInput.setAsDefault()
        // Hide keyboard at the first time
        initTapGesture()
        // Keyboard `height = 0` at the first time
        updateKeyboard(height: 0)
        // Notification
        initNotifications()
    }
}

// MARK: - Nofitication

private var Notification = NotificationCenter.default
extension ViewController {
    private func initNotifications() {
        Notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification,  object: nil)
        Notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification,  object: nil)
    }
    
    private func removeNotifications() {
        Notification.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let isHideKeyboard: Bool = (notification.name == UIResponder.keyboardWillHideNotification)
        
        // MARK: You can use If-else:
        /*
        if isHideKeyboard{
            updateKeyboard(height: 0)
         }
         else {
            updateKeyboard(height: notification.keyboardHeight)
        }
        */
        
        // MARK: OR using this `Shorthand If`
        updateKeyboard(height: (isHideKeyboard ? 0 : notification.keyboardHeight))
     }
}




// MARK: - Handle Keyboard state

extension ViewController {
    private func updateKeyboard(height: CGFloat) {
        if let unNULL_paddingBottomHeight = paddingBottomHeight {
            unNULL_paddingBottomHeight.constant = height
        }
    }
}




// MARK: - Tapgesture (Tap on to hide the keyboard if needed)

extension ViewController {
    private func initTapGesture() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}




// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    //keyboard return
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
        
    }

    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        // MARK: Optional variable
        // see: https://medium.com/@agoiabeladeyemi/optionals-in-swift-2b141f12f870
        let customTextField = (textField as? CustomTextField)
        customTextField?.setAsHighlight()
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // MARK: Optional variable
        // see: https://medium.com/@agoiabeladeyemi/optionals-in-swift-2b141f12f870
        let customTextField = (textField as? CustomTextField)
        customTextField?.setAsDefault()
    }
}




// MARK: - Notification extension
// You can create any custom-functions by yourself

fileprivate
extension Notification {
    var keyboardHeight: CGFloat {
        let keyboardFrame: NSValue = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        return keyboardRectangle.size.height
    }
}
