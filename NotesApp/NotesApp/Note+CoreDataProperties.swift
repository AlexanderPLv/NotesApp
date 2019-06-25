//
//  Note+CoreDataProperties.swift
//  NotesApp
//
//  Created by MacMini on 25/06/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String

}
