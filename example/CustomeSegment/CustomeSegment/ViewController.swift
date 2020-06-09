//
//  ViewController.swift
//  CustomeSegment
//
//  Created by Tèo Lực on 6/5/20.
//  Copyright © 2020 Ahamove. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        //
        let screenWidth: CGFloat = view.bounds.size.width
        let x: CGFloat = 20.0
        let y: CGFloat = 60
        let width: CGFloat = (screenWidth - x * 2)
        let height: CGFloat = 38
        //
        let segment = CustomSegment.loadFromXIB()
        segment.delegate = self
        segment.frame = CGRect.init(x: x, y: y, width: width, height: height)
        //
        segment.autoresizingMask = .flexibleWidth
        //
        self.view.addSubview(segment)
        
        let starRating = CustomRating.loadFromXIB()
        starRating.delegate = self
        starRating.frame = CGRect.init(x: 20, y: 200, width: 237, height: 22)
        starRating.autoresizingMask = .flexibleWidth
        self.view.addSubview(starRating)
    }
}

extension ViewController: CustomSegmentDelegate {
   func didSelectedItem(at index: Int) {
       print("didSelectedItem: \(index)")
   }
}

extension ViewController: CustomRatingDelegate {
    func didSelectedRating(at index: Int) {
        print("didSelectedRating: \(index)")
    }
}
