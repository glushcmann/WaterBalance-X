//
//  User.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var weight = 0
    @objc dynamic var goal = 0
    @objc dynamic var wakeup: Date?
    @objc dynamic var asleep: Date?
    @objc dynamic var interval: Date?
    
}
