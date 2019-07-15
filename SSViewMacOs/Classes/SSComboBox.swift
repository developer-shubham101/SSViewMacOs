//
//  SSComboBox.swift
//  SSViewMacOs
//
//  Created by Arka Softwares on 08/07/19.
//

import Cocoa


typealias SSComboBoxString = String

public protocol SSComboBoxObject {
    var string: String {get}
}
extension SSComboBoxString: SSComboBoxObject {
    public var string: String {
        get {
            return self
        }
    }
}
public protocol SSComboBoxDelegate {
    func optionChange(_ ssDropDown:SSComboBox, selectedIndex:Int, selectedItem: SSComboBoxObject?)
}
public class SSComboBox: NSComboBox, NSComboBoxCellDataSource, NSComboBoxDataSource, NSComboBoxDelegate {
    
    public var ssComboDelegate:SSComboBoxDelegate?
    
    
    override public func awakeFromNib() {
        usesDataSource = true
        
        dataSource = self
        completes = true
        delegate = self
        target = self
        action = #selector(enterTaped)
        
        reloadData()
        
    }
    //    override func draw(_ dirtyRect: NSRect) {
    //        super.draw(dirtyRect)
    //
    //        // Drawing code here.
    //    }
    
    public var comboData:[SSComboBoxObject] {
        set {
            _comboData = newValue
            reloadData()
        }
        get {
            return _comboData
        }
    }
    
    @objc private func enterTaped(_ sender: NSComboBox)  {
        
        var selectedItem: SSComboBoxObject?
        
        if sender.indexOfSelectedItem >= 0 && sender.indexOfSelectedItem < _comboData.count {
            selectedItem = _comboData[sender.indexOfSelectedItem]
        }
        ssComboDelegate?.optionChange(self, selectedIndex: sender.indexOfSelectedItem, selectedItem: selectedItem)
    }
    private var _comboData:[SSComboBoxObject] = []
    
    public func comboBox(_ comboBox: NSComboBox, completedString string: String) -> String? {
        
        print("SubString = \(string)")
        
        for state  in _comboData {
            // substring must have less characters then stings to search
            if string.count < state.string.count{
                // only use first part of the strings in the list with length of the search string
                let statePartialStr = state.string.lowercased()[state.string.lowercased().startIndex..<state.string.lowercased().index(state.string.lowercased().startIndex, offsetBy: string.count)]
                if statePartialStr.range(of: string.lowercased()) != nil {
                    print("SubString Match = \(state)")
                    return state.string
                }
            }
        }
        return ""
    }
    
    public func numberOfItems(in comboBox: NSComboBox) -> Int {
        return(_comboData.count)
    }
    
    public func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        return(_comboData[index].string)
    }
    
    public func comboBox(_ comboBox: NSComboBox, indexOfItemWithStringValue string: String) -> Int {
        var i = 0
        for str in _comboData {
            if str.string == string {
                return i
            }
            i += 1
        }
        return -1
    }
    
    public func comboBoxSelectionDidChange(_ notification: Notification) {
        
        //        print(notification )
        let comboBox = notification.object as! NSComboBox
        
        if comboBox == self {
            var selectedItem: SSComboBoxObject?
            if comboBox.indexOfSelectedItem >= 0 && comboBox.indexOfSelectedItem < _comboData.count {
                selectedItem = _comboData[comboBox.indexOfSelectedItem]
            }
            ssComboDelegate?.optionChange(self, selectedIndex: comboBox.indexOfSelectedItem, selectedItem: selectedItem)
        }
    }
}
