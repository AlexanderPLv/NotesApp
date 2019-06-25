//
//  ViewController.swift
//  NotesApp
//
//  Created by MacMini on 25/06/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        loadNotes()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.body
        cell.textLabel?.numberOfLines = 0
        
        return cell
        
    }
    
    private func loadNotes() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            guard let notes = fetchedObjects as? [Note] else { return }
            
            self.notes = notes
            self.tableView.reloadData()
            
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func didTapBarButton(_ sender: Any) {
       
        let alert = UIAlertController(title: "Add Note", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let saveAction = UIAlertAction(title: "Save Note", style: .default) { (_) in
            
         guard let noteBody = alert.textFields?.first?.text,
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            let newNote = Note(context: context)
            newNote.body = noteBody
            self.notes.append(newNote)
            
            appDelegate.saveContext()
            self.tableView.reloadData()
        }
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
    
    
    
}

