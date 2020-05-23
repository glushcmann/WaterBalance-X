//
//  CalcVC.swift
//  WaterBalance X
//
//  Created by Никита on 20.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Eureka

class CalcVC: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Расчет воды"
        
        form
        +++ Section("Ваш вес")
            <<< ButtonRow(){
                $0.title = "75 кг"
            }
        +++ Section(header: "Предлагаемое количество воды", footer: "Значение носит рекомендательный характер. Никогда не помешает проконсультироваться с вашим врачом относительно подходящего для вас количества воды.")
            <<< ButtonRow(){
                $0.title = "2625 мл"
            }
    }
}
