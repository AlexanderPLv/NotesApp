//
//  ViewController.swift
//  NotesApp
//
//  Created by MacMini on 25/06/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        cell.selectionStyle = .none
        
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
        
        performSegue(withIdentifier: "segue.Main.NotesTableViewToNoteEditor", sender: nil)
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let note = notes[indexPath.row]
        
        let alert = UIAlertController(title: "Edit Note", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = note.body
        }
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
            
            guard let updatedNoteBody = alert.textFields?.first?.text,
                let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            note.body = updatedNoteBody
            appDelegate.saveContext()
            self.loadNotes()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
        
    }
    
    
    
}

