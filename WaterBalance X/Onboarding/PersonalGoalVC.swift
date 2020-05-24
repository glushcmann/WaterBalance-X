//
//  PersonalGoalVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Eureka

class PersonalGoalVC: FormViewController {
    
    let weight = UserDefaults.standard.integer(forKey: "weight")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let goal = weight * 33
        
        UserDefaults.standard.removeObject(forKey: "goal")
        UserDefaults.standard.set(goal, forKey: "goal")
        
        navigationItem.title = "Ваша рекомендация"
        
        
        form
            +++ Section("Рекомендуемый объем воды")
                <<< ButtonRow(){
                    $0.title = "\(goal) мл"
                }
            
            +++ Section(footer: "Эта число носит рекомендательный характер. Желательно проконсультироваться с вашим врачом.")
                <<< ButtonRow(){
                    $0.title = "Далее"
                }.onCellSelection({_,_ in
                    self.navigationController?.pushViewController(SetupNotificationsVC(), animated: true)
                })
    }
    
}
