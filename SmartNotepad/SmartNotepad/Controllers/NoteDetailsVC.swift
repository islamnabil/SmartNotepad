//
//  NoteDetailsVC.swift
//  SmartNotepad
//
//  Created by Islam Elgaafary on 23/04/2021.
//

import UIKit

class NoteDetailsVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteBodyTextView: UITextView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        noteBodyTextView.delegate = self
        noteBodyTextView.textColor = UIColor.lightGray
    }
    
    // MARK: - Private Methods
    
    // MARK: - Public Methods
    
    // MARK: - IBActions
    @IBAction func addLocation(_ sender: Any) {
    }
    
    @IBAction func addPhoto(_ sender: Any) {
    }
    
}

// MARK: - UITextViewDelegate
extension NoteDetailsVC:UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Note Body Here"
            textView.textColor = UIColor.lightGray
        }
    }
}
