//
//  Category.swift
//  Todoey
//
//  Created by Mark Eve on 26.01.18.
//  Copyright © 2018 Mark Eve. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
   @objc dynamic var name: String = ""
   let items = List<Item>()
}
