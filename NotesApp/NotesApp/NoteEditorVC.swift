//
//  NoteEditorVC.swift
//  NotesApp
//
//  Created by MacMini on 26/06/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

class NoteEditorVC: UIViewController {
    
    @IBOutlet weak var noteEditorTextView: UITextView!
    @IBOutlet weak var categoryTextField: UITextField!
    
    
    var note: Note?
    var userDisSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = doneBarButtonItem
        navigationItem.title = "New Note"
        if let note = self.note {
            noteEditorTextView.text = note.body
            navigationItem.title = "Edit Note"
            categoryTextField.isUserInteractionEnabled = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteEditorTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if userDisSave == false {
            saveNote()
        }
    }
    
    
    @objc func didTapDone() {
        userDisSave = true
        saveNote()
        
        navigationController?.popViewController(animated: true)
    }
    
    func saveNote() {
        
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            noteEditorTextView.text.isEmpty == false
            else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        if let note = self.note {
            note.body = noteEditorTextView.text
        } else {
            let newNote = Note(context: context)
            newNote.body = noteEditorTextView.text
            
            let category = Category(context: context)
            category.category = categoryTextField.text
            newNote.category = category
        }
        appDelegate.saveContext()
        
    }
    
}
