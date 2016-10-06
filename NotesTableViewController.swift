//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Uldis Zingis on 30/09/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController, UISearchBarDelegate, UITextFieldDelegate {
    
    var searchActive = false
    var filtered = [Note]()
    
    @IBOutlet var searchBar: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var notes = [Note]()
        if searchActive {
            notes = filtered
        } else {
            notes = NotesController.sharedController.notes
        }
        
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        var notes = [Note]()
        if searchActive {
            notes = filtered
        } else {
            notes = NotesController.sharedController.notes
        }
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.text
        
        // Set cell description with formatted date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        let formattedDate = formatter.string(from: note.timestamp as Date)
        cell.detailTextLabel?.text = "\(formattedDate)"

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var notes = [Note]()
            if searchActive {
                notes = filtered
                let note = notes[indexPath.row]
                NotesController.sharedController.removeNote(note: note)
                searchActive = false
                tableView.reloadData()
            } else {
                notes = NotesController.sharedController.notes
                let note = notes[indexPath.row]
                NotesController.sharedController.removeNote(note: note)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    // MARK: - Search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchBarText = searchBar.text {
            filtered = NotesController.sharedController.notes.filter({
                $0.includesText(text: searchBarText)
            })
            if(filtered.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
            tableView.reloadData()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        if segue.identifier == "toExistingNote" {
            if let nextVC = segue.destination as? NoteViewController, let indexPath = tableView.indexPathForSelectedRow {
                var notes = [Note]()
                if searchActive {
                    notes = filtered
                } else {
                    notes = NotesController.sharedController.notes
                }
                let note = notes[indexPath.row]
                nextVC.note = note
            }
        }
    }
}
