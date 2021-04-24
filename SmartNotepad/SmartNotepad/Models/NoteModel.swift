//
//  NoteModel.swift
//  SmartNotepad
//
//  Created by Islam Elgaafary on 23/04/2021.
//

import Foundation
import RealmSwift

class NoteModel: Object {
  @objc dynamic var title = ""
  @objc dynamic var body = ""
  @objc dynamic var latitude = 0.0
  @objc dynamic var longitude = 0.0
  @objc dynamic var locationAddress = ""
  @objc dynamic var image = ""
  @objc dynamic var createdAt = Date()
  @objc dynamic var distanceFromDevice = 0.0
}
