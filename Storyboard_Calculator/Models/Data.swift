//
//  Data.swift
//  Storyboard_Calculator
//
//  Created by MacBook on 7/31/20.
//  Copyright © 2020 ngg666. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    
    @objc dynamic var user: String = ""
    @objc dynamic var operation: String = ""
    @objc dynamic var timestamp: Date?
    
}
