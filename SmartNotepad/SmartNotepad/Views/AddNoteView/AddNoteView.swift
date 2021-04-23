//
//  AddNoteView.swift
//  SmartNotepad
//
//  Created by Islam Elgaafary on 23/04/2021.
//

import UIKit

protocol AddNoteViewDelegate {
    func addNote()
}

class AddNoteView: UIView {
    //MARK:- Properties
    var delegate:AddNoteViewDelegate!
    
    //MARK:- IBActions
    @IBAction func addNote(_ sender: Any) {
        delegate?.addNote()
    }
    
}
