//
//  NotificationsVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Eureka

class NotificationsVC: FormViewController {
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Напоминания"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(close))
        
        form
            +++ Section()
                <<< SwitchRow(){
                    $0.title = "Уведомления"
                }
        
            +++ Section(footer: "Среднее количество воды для каждого уведомления X")
                <<< PickerInlineRow<Date>(){
                    $0.title = "Я просыпаюсь в"
                }
                <<< PickerInlineRow<Date>(){
                    $0.title = "Я ложусь спать в"
                }
                <<< PickerInlineRow<Date>(){
                    $0.title = "Интервал между уведомлениями"
                }
        
            +++ Section()
                <<< LabelRow(){
                    $0.title = "Звук оповещения"
                }
    }
}
