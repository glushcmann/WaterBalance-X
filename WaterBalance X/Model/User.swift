//
//  User.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

struct User {
    var weight: Int
    var goal: Int
    var wakeup: Date
    var asleep: Date
    var interval: Date
}

//class ViewModel {
//    var user: User
//    
//    var weight: Observable<Int>
//    var goal: Observable<Int>
//    var wakeup: Observable<Date>
//    var asleep: Observable<Date>
//    var interval: Observable<Date>
//    
//    init(user: User) {
//        self.user = user
//    }
//    
//}
