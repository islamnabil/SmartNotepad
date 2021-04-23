//
//  NotesVC.swift
//  SmartNotepad
//
//  Created by Islam Elgaafary on 23/04/2021.
//

import UIKit

class NotesVC: UIViewController {
    //MARK:- Properties
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var notesTableView: UITableView!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNoteTable()
        notesTableView.backgroundView = createAddNoteView()
        
    }
    
    
    func createAddNoteView() -> AddNoteView {
        let view = UINib(nibName: "AddNoteView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AddNoteView
        return view
    }
    
    //MARK:- Private Methods
    fileprivate func configureNoteTable() {
        notesTableView.register(UINib(nibName: "NoteTableCell", bundle: nil), forCellReuseIdentifier: "NoteTableCell")
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    
}

// MARK: - UITableView Delegate
extension NotesVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoteTableCell.self),for: indexPath) as! NoteTableCell
        cell.nearestLabel.isHidden = (indexPath.row != 0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 65
    }
    
}

