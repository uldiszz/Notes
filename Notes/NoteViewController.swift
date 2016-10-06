//
//  NoteViewController.swift
//  Notes
//
//  Created by Uldis Zingis on 30/09/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    var note: Note?

    @IBOutlet weak var noteTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFieldsWith()
    }
    
    func updateFieldsWith() {
        if note != nil {
             noteTextField.text = note?.text
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        if let text = noteTextField.text {
            if note == nil && text != "Your note here..." {
                NotesController.sharedController.createNote(text: text)
            } else if text != "Your note here..." {
                if let note = note {
                    NotesController.sharedController.updateNote(note: note, text: text)
                }
            }
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
