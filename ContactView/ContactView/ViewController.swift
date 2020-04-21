//
//  ViewController.swift
//  ContactView
//
//  Created by Temp on 4/20/20.
//  Copyright © 2020 Fabi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var contactView: UITableView!
    
    var namesGroup = [String:[Contact]]()
    var keySectionTitles = [String]()
    var filterArray: [Contact] = []
    let contacts:[Contact] = ContactDataProvider.contacts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        contactView.delegate = self
        contactView.dataSource = self
        searchBar.delegate = self
        
        if searchBar.searchTextField.text?.isEmpty == true {
            filterArray = contacts
        }
        
        for key in filterArray {
         
            let keysection = String(key.name.prefix(1))
            if var keyvalues = namesGroup[keysection] {
                
                keyvalues.append(key)
                namesGroup[keysection] = keyvalues
                
            }
            else {
                
                namesGroup[keysection] = [key]
                
            }
            
        }
        
        keySectionTitles = [String](namesGroup.keys)
        keySectionTitles = keySectionTitles.sorted(by: {$0 < $1})
        
        print(keySectionTitles)
        print(namesGroup)
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you taped \(filterArray[indexPath.row])")
    }
    
    
}


extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return keySectionTitles.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let keysection = keySectionTitles[section]
        if let keyvalues = namesGroup[keysection] {
 
            return keyvalues.count
            
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        let keysection = keySectionTitles[indexPath.section]
        
        if let keyvalues = namesGroup[keysection] {
            
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            
            let contact = keyvalues[indexPath.row]
            
            cell.textLabel?.text = contact.name
            
            cell.detailTextLabel?.text = contact.phoneNumber
              
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return keySectionTitles[section]
        
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        UIView.animate(withDuration: 0.3 ) {
            
            self.view.layoutIfNeeded()
            
        }
        
        contactView.isHidden = false
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        filterArray = contacts
        namesGroup = [String:[Contact]]()
        
        if searchText.isEmpty == false {
            
            filterArray = contacts.filter({$0.name.contains(searchText)})
            
        }
        
        for key in filterArray {
            
            let keysection = String(key.name.prefix(1))

           
            if var keyvalues = namesGroup[keysection] {
                
                keyvalues.append(key)
                namesGroup[keysection] = keyvalues

            }
            else {
                
                namesGroup[keysection] = [key]
            }
        
        }
        
        keySectionTitles = [String](namesGroup.keys)
        keySectionTitles = keySectionTitles.sorted(by: {$0 < $1})
        
        contactView.reloadData()
   
    }
    
}
