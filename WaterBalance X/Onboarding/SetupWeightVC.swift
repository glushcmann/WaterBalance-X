//
//  SetupWeightVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Eureka

class SetupWeightVC: FormViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Введите вес"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true

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
                    $0.placeholder = "введите здесь"
                    $0.add(ruleSet: rules)
                    $0.validationOptions = .validatesOnChange
                }.onChange({
                    UserDefaults.standard.removeObject(forKey: "weight")
                    UserDefaults.standard.set($0.value, forKey: "weight")
                })
            
            +++ Section(footer: "Сообщите нам ваш вес, он необходим для того, чтобы предложить подходящее для вас количество воды в день.")
                <<< ButtonRow(){
                    $0.title = "Далее"
                }.onCellSelection({_,_ in
                    if ( UserDefaults.standard.integer(forKey: "weight") > 0 && UserDefaults.standard.integer(forKey: "weight") < 300) {
                        self.navigationController?.pushViewController(PersonalGoalVC(), animated: true)
                    }
                })
    }
    
}
