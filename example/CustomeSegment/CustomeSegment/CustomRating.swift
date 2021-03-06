//
//  CustomRating.swift
//  CustomeSegment
//
//  Created by Admin on 6/10/20.
//  Copyright © 2020 Ahamove. All rights reserved.
//

import UIKit


class CustomRating: UIView {

    //weak var delegate : CustomRatingDelegate?
    
    @IBOutlet var starButton: [UIButton]!
    
    //@IBAction func buttonTapped(_ sender: UIButton) {
    func starRating (_ starrated: Int) {
        //delegate?.didSelectedRating(at: sender.tag)
        
        for button in starButton {
            if button.tag <= starrated {
                button.setBackgroundImage(UIImage.init(named: "startOn"), for: .normal)
            } else {
                button.setBackgroundImage(UIImage.init(named: "startOff"), for: .normal)
            }
            
        }
    }

}

extension CustomRating {
    static func loadFromXIB() -> CustomRating {
        let viewsInXIB = Bundle.main.loadNibNamed("CustomRating", owner: nil, options: nil)
        return viewsInXIB?.first as! CustomRating
    }
}
