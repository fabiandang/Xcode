//
//  CustomTextField.swift
//  Game3
//
//  Created by Tèo Lực on 4/18/20.
//  Copyright © 2020 Fabi. All rights reserved.
//

import UIKit.UITextField

class CustomTextField: UITextField {
    private
    struct ColorDefined {
        static let `default` = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1).cgColor
        static let highlight = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1).cgColor
    }
    
    // MARK: - UIView's constructors
    // We have: CustomTextField >> UITextField >> UIView
    // `>>` means implementation
    // For more info: please see this link: https://developer.apple.com/documentation/uikit/uiview (Creating a View Object)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Private functions
    private func setup() {
        layer.cornerRadius = 4.0
        layer.borderWidth = 0.5
    }
    
    // MARK: - Public functions
    
    func setAsDefault() {
        layer.borderColor = ColorDefined.default
    }
    func setAsHighlight() {
        layer.borderColor = ColorDefined.highlight
    }

}
