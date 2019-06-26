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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteEditorTextView.becomeFirstResponder()
    }
    
    
    @objc func didTapDone() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newNote = Note(context: context)
        newNote.body = noteEditorTextView.text
        appDelegate.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
}
