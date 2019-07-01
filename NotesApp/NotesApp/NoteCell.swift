//
//  NoteCell.swift
//  NotesApp
//
//  Created by MacMini on 28/06/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteBodyLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .gray
        textLabel?.numberOfLines = 0
    }
    
   
}
extension NoteCell {
    public func populate(with note: Note) {
        categoryLabel.text = note.category?.category
        noteBodyLabel.text = note.body
    }
    
}




