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
        
        self.hideKeyboardWhenTappedAround()
        
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
            
            cell.textLabel?.attributedText = self.filterAndModifyTextAttributes(searchStringCharacters: (self.searchBar?.text)!, completeStringWithAttributedText: contact.name)
              
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return keySectionTitles[section]
        
    }
    
    private func filterAndModifyTextAttributes(searchStringCharacters: String, completeStringWithAttributedText: String) -> NSMutableAttributedString {

        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: completeStringWithAttributedText)
        
        let pattern = searchStringCharacters.lowercased()
        
        let range: NSRange = NSMakeRange(0, completeStringWithAttributedText.count)
        
        var regex = NSRegularExpression()
        
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
            regex.enumerateMatches(in: completeStringWithAttributedText.lowercased(), options: NSRegularExpression.MatchingOptions(), range: range) {
                (textCheckingResult, matchingFlags, stop) in
                let subRange = textCheckingResult?.range
                let attributes : [NSAttributedString.Key : Any] = [.font : UIFont.boldSystemFont(ofSize: 17),.foregroundColor: UIColor.red ]
                attributedString.addAttributes(attributes, range: subRange!)
            }
        }
        catch {
            
            print(error.localizedDescription)
            
        }
        
        return attributedString
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
            
            //filterArray = contacts.filter({$0.name.contains(searchText)})
            filterArray  = contacts.filter({$0.name.lowercased().contains(searchText.lowercased())})
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


