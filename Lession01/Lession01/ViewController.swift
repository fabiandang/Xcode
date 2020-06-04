//
//  ViewController.swift
//  Lession01
//
//  Created by Admin on 6/1/20.
//  Copyright © 2020 Fabian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowtoDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = rowtoDisplay[indexPath.row]
        
        return cell
    }
    

    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Now Playing","Popular","Upcomming","Top Rated"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    
    @objc func handleSegmentChange() {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            rowtoDisplay = nowPlaying
        case 1:
            rowtoDisplay = Popular
        case 2:
            rowtoDisplay = upComming
        default:
            rowtoDisplay = topRated
        }
        tableView.reloadData()
        
    }
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let nowPlaying = ["Playing1","Playing2","Playing3","Playing4"]
    
    let Popular = ["Popular1","Popular2","Popular3","Popular4"]
    
    let upComming = ["Upcomming1","Upcomming2","Upcomming3","Upcomming4"]
    
    let topRated = ["Top1","Top2","Top3","Top4"]
    
    lazy var rowtoDisplay = nowPlaying
    
    @IBOutlet weak var customSeg: CustomSegment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        
        let paddedStackview = UIStackView(arrangedSubviews: [segmentedControl])
        paddedStackview.layoutMargins = .init(top: 12, left: 5, bottom: 5, right: 5)
        paddedStackview.isLayoutMarginsRelativeArrangement = true
        
        let stackView = UIStackView(arrangedSubviews: [paddedStackview, tableView])
        
        stackView.axis = .vertical
        
        //view.addSubview(stackView)
        
        //stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 400, right: 0))
        
        let customSegment = CustomSegment(frame: CGRect(x:20.0,y:20.0,width: self.view.safeAreaLayoutGuide.layoutFrame.width ,height: self.view.safeAreaLayoutGuide.layoutFrame.height))
        self.view.addSubview(customSegment)
        
        print(self.view.safeAreaLayoutGuide.layoutFrame.width)
        print(self.view.safeAreaLayoutGuide.layoutFrame.height)
        
    }


}

