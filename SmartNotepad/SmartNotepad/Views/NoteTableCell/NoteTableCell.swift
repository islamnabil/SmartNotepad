//
//  NoteTableCell.swift
//  SmartNotepad
//
//  Created by Islam Elgaafary on 23/04/2021.
//

import UIKit

class NoteTableCell: UITableViewCell {
    //MARK:- Properties
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteBodyLabel: UILabel!
    @IBOutlet weak var nearestLabel: UILabel!
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var noteImage: UIImageView!
    
    //MARK:- View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Private Methods
    fileprivate func isHasImage(note:NoteModel) -> Bool {
        return note.image != ""
    }
    fileprivate func isHasLocationAddress(note:NoteModel) -> Bool {
        return note.locationAddress != ""
    }
    
    //MARK:- Public Methods
    func configureView(note:NoteModel){
        noteTitleLabel.text = note.title
        noteBodyLabel.text = note.body
        noteImage.isHidden = !isHasImage(note: note)
        pinImage.isHidden = !isHasLocationAddress(note: note)
    }
    
}
