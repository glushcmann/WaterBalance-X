//
//  UnitsVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Eureka

class UnitsVC: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Единицы измерения"
        
        form
        +++ Section("Вода")
            <<< CheckRow() {
                $0.title = "мл"
            }
            <<< CheckRow() {
                $0.title = "унции"
            }
        
        +++ Section("Вес")
            <<< CheckRow() {
                $0.title = "кг"
            }
            <<< CheckRow() {
                $0.title = "фунты"
            }
    }
}
