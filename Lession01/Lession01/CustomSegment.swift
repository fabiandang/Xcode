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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInitialization() {
        let view = Bundle.main.loadNibNamed("CustomSegment", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
    }

}
