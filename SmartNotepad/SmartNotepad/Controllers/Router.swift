//
//  Router.swift
//  SmartNotepad
//
//  Created by Islam Elgaafary on 23/04/2021.
//

import UIKit

enum Storyboards:String {
    case Main = "Main"
}

enum VCs:String {
    case NoteDetailsVC = "NoteDetailsVC"
}

protocol StoryboardViewController {
    var storyboard:String {get}
}

extension VCs: StoryboardViewController {
    var storyboard: String {
        switch self {
        case .NoteDetailsVC:
            return Storyboards.Main.rawValue
        }
    }
}

extension UIViewController {
    func pushNoteDetailsVC(note:NoteModel? = nil) {
        let vc = UIStoryboard(name: VCs.NoteDetailsVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: String(describing: NoteDetailsVC.self)) as! NoteDetailsVC
        vc.setData(note: note)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
