//
//  ViewController.swift
//  SSViewMacOs
//
//  Created by shubhamsharma95 on 07/08/2019.
//  Copyright (c) 2019 shubhamsharma95. All rights reserved.
//

import Cocoa
import SSViewMacOs

struct ComboItems: SSComboBoxObject {
    var string: String {
        get {
            return "\(firstName)  \(lastName)"
        }
    }
     
    var firstName = ""
    var lastName = ""
    var position = ""
//    init( firstName:String, lastName:String, position:String ) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.position = position
//    }
}
class ViewController: NSViewController, SSComboBoxDelegate {
    
    @IBOutlet weak var comboWithString: SSComboBox!
    @IBOutlet weak var comboWithCustomObj: SSComboBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comboWithString.comboData = ["Shubham Sharma", "Nikhil Jain"]
        
        comboWithCustomObj.comboData = [
            ComboItems(firstName: "Shubham", lastName: "Sharma", position: "Developer"),
            ComboItems(firstName: "Nikhil", lastName: "Jain", position: "QA")
        ]
        comboWithString.ssComboDelegate = self
        comboWithCustomObj.ssComboDelegate = self
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func optionChange(_ ssDropDown: SSComboBox, selectedIndex: Int, selectedItem: SSComboBoxObject?) {
        if ssDropDown == comboWithString {
            print(selectedItem)
        }else if ssDropDown == comboWithCustomObj {
            if let item:ComboItems = selectedItem as? ComboItems {
                print(item.position)
            }
        }
    }
  
}

