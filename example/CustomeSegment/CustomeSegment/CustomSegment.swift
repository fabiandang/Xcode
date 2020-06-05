//
//  CustomSegment.swift
//  CustomeSegment
//
//  Created by Tèo Lực on 6/5/20.
//  Copyright © 2020 Ahamove. All rights reserved.
//

import UIKit

// MARK: Protocol
protocol CustomSegmentDelegate: NSObject {
    func didSelectedItem(at index: Int)
}

// MARK: Custom
class CustomSegment: UIView {
    
    // MARK: Properties (IBOutlet)
    @IBOutlet weak private var btn1: UIButton!
    @IBOutlet weak private var btn2: UIButton!
    @IBOutlet weak private var btn3: UIButton!
    @IBOutlet weak private var btn4: UIButton!
    
    // MARK: Property (lazy)
    lazy var items: [UIButton] = {
        return [btn1, btn2, btn3, btn4]
    }()
    
    // MARK: Property (Other(s))
    private var selectedIndex: Int = 0
    weak var delegate: CustomSegmentDelegate?
    
    // MARK: override from super class (UIView)
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        firstLoad()
    }
}

// MARK: - Actions

extension CustomSegment {
    @IBAction func didTapOn(_ button: UIButton) {
        // 1. Validation: Is `selectedIndex` existed ????
        guard let index = items.firstIndex(of: button) else {
            return
        }
        // 2. Update state
        selectItem(at: index)
        // 3. Call back
        delegate?.didSelectedItem(at: index)
    }
}

// MARK: - State

extension CustomSegment {
    // 1. Is First Load UI
    private func firstLoad() {
        let index = 0
        selectItem(at: index)
        delegate?.didSelectedItem(at: index)
    }
    
    // 2. Update state
    private func selectItem(at index: Int) {
        for (i, btn) in items.enumerated() {
            // 1. Is Equal
            if i == index {
                btn.isSelected = true
            }
            // 2. Or not
            else {
                btn.isSelected = false
            }
            
            /* // *******THE BEST SUGGESTION: *******
            btn.isSelected = (index == selectIndex)
            */
        }
    }
}

// MARK: - Load CustomSegment from XIB file
extension CustomSegment {
    static func loadFromXIB() -> CustomSegment {
        let viewsInXIB = Bundle.main.loadNibNamed("CustomSegment", owner: nil, options: nil)
        return viewsInXIB?.first as! CustomSegment
    }
}
