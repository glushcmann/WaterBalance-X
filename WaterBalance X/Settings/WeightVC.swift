//
//  WeightVC.swift
//  WaterBalance X
//
//  Created by Никита on 23.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Eureka

class WeightVC: FormViewController {
    
    let weight = UserDefaults.standard.integer(forKey: "weight")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Вес"
        view.backgroundColor = .systemBackground

        var rules = RuleSet<Int>()
        let rule = RuleClosure<Int> { rowValue in
            return (rowValue == nil) ? ValidationError(msg: "Field required!") : nil
        }
        rules.add(rule: rule)
        rules.add(rule: RuleSmallerThan(max: 300))
        
        form
            +++ Section("Ваш вес")
                <<< IntRow(){
                    $0.title = "Вес:"
                    $0.placeholder = "\(weight)"
                    $0.add(ruleSet: rules)
                    $0.validationOptions = .validatesOnChange
                }.onChange({
                    let goal = $0.value! * 33
                    UserDefaults.standard.removeObject(forKey: "weight")
                    UserDefaults.standard.removeObject(forKey: "goal")
                    UserDefaults.standard.set($0.value, forKey: "weight")
                    UserDefaults.standard.set(goal, forKey: "goal")
                    let vc = MainVC()
                    vc.goalLabel.text = "\(goal) мл"
                })
            
            +++ Section()
                <<< ButtonRow(){
                    $0.title = "Изменить"
                }.onCellSelection({_,_ in
                    if ( UserDefaults.standard.integer(forKey: "weight") > 0 && UserDefaults.standard.integer(forKey: "weight") < 300) {
                        self.navigationController?.popViewController(animated: true)
                    }
                })
    }
    
}
