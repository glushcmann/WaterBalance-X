//
//  User.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import Foundation

class User {
    
    var weight = UserDefaults.standard.integer(forKey: "weight")
    var goal = UserDefaults.standard.integer(forKey: "goal")
    var isNotificationsOn: Void = UserDefaults.standard.set(false, forKey: "isNotify")
    
}
