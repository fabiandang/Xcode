//
//  CustomSegment.swift
//  Lession01
//
//  Created by Admin on 6/3/20.
//  Copyright © 2020 Fabian. All rights reserved.
//

import UIKit

class CustomSegment: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        
        
        let view = Bundle.main.loadNibNamed("CustomSegment", owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.frame.size.width = (view.frame.width / 2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.frame.size.width = view.frame.width / 4
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.frame.size.width = view.frame.width / 4
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.frame.size.width = view.frame.width / 4
        
        addSubview(view)
        view.addSubview(button1)
        print(button1.frame.size.width)
        print(view.frame.width)
    }

}
