//
//  User.swift
//  summerHomeWork
//
//  Created by WooL on 2020/9/8.
//  Copyright © 2020 WooL. All rights reserved.
//

import Foundation
import RealmSwift

class Users : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var account = ""
    @objc dynamic var passwd = ""
    @objc dynamic var name = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}

