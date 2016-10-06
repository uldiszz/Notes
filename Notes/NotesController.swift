//
//  NotesController.swift
//  Notes
//
//  Created by Uldis Zingis on 30/09/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import Foundation

class NotesController {
    
    let kNotes = "kNotes"
    
    static let sharedController = NotesController()
    
    var notes: [Note] = []
    
    init() {
        load()
    }
    
    func createNote(text: String) {
        let note = Note(text: text)
        notes.append(note)
        save()
    }
    
    func removeNote(note: Note) {
        if let index = notes.index(of: note) {
            notes.remove(at: index)
        }
        save()
    }
    
    func updateNote(note: Note, text: String) {
        note.text = text
        save()
    }
    
    func save() {
        var allNotesDict = [[String: Any]]()
        for note in notes {
            allNotesDict.append(note.toDictionary)
        }
        UserDefaults.standard.set(allNotesDict, forKey: kNotes)
    }
    
    func load() {
        if let allDict = UserDefaults.standard.array(forKey: kNotes) {
            for dict in allDict {
                if let dict = dict as? [String : Any], let note = Note(dictionary: dict) {
                    notes.append(note)
                }
            }
        }
    }
}
