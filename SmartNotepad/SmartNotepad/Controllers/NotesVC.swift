//
//  NotesVC.swift
//  SmartNotepad
//
//  Created by Islam Elgaafary on 23/04/2021.
//

import UIKit
import RealmSwift

class NotesVC: UIViewController {
    //MARK:- Properties
    var notes = try! Realm().objects(NoteModel.self)
    
    //MARK:- IBOutlets
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNoteTable()
    }
    override func viewWillAppear(_ animated: Bool) {
        notes.count == 0 ? setupEmptyNotesView() : setupNonEmptyNotesView()
    }
    
    //MARK:- IBActions
    @IBAction func addNote(_ sender: Any) {
        pushNoteDetailsVC()
    }
    
    //MARK:- Private Methods
    fileprivate func configureNoteTable() {
        notesTableView.register(UINib(nibName: "NoteTableCell", bundle: nil), forCellReuseIdentifier: "NoteTableCell")
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    
    fileprivate func createAddNoteView() -> AddNoteView {
        let addNoteView = UINib(nibName: "AddNoteView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AddNoteView
        addNoteView.delegate = self
        return addNoteView
    }
    
    fileprivate func setupEmptyNotesView(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        notesTableView.backgroundView = createAddNoteView()
        notesTableView.separatorStyle = .none
    }
    
    fileprivate func setupNonEmptyNotesView(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        notesTableView.backgroundView = nil
        notesTableView.separatorStyle = .singleLine
    }
    
}

// MARK: - UITableView Delegate
extension NotesVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoteTableCell.self),for: indexPath) as! NoteTableCell
        cell.configureView(note: notes[indexPath.row])
        cell.nearestLabel.isHidden = (indexPath.row != 0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}

// MARK: - AddNoteView Delegate
extension NotesVC: AddNoteViewDelegate {
    func addNoteButtonAction() {
        pushNoteDetailsVC()
    }
}

