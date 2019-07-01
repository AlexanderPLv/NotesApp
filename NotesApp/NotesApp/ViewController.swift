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
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNotes()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell else { return UITableViewCell() }
        
        let note = notes[indexPath.row]
        cell.populate(with: note)
        
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
        performSegue(withIdentifier: "segue.Main.NotesTableViewToNoteEditor", sender: note)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let noteEditorVC = segue.destination as? NoteEditorVC,
            let note = sender as? Note {
            
            noteEditorVC.note = note
            
        }
        
    }
    
    
}

