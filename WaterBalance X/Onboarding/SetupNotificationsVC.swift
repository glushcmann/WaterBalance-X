//
//  SetupNotificationsVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Eureka

class SetupNotificationsVC: FormViewController {
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Последний шаг, напоминания"
        view.backgroundColor = .systemBackground
        
        dateFormatter.dateFormat = "HH:mm"
        let dateWakeup: Date? = dateFormatter.date(from: "10:00")
        let dateAsleep: Date? = dateFormatter.date(from: "00:00")
        let dateInterval: Date? = dateFormatter.date(from: "02:00")
        
        form
            +++ Section()
                <<< TimeRow(){
                    $0.title = "Я просыпаюсь в"
                    $0.value = dateWakeup
                }.onChange({value in
                    UserDefaults.standard.removeObject(forKey: "wakeup")
                    UserDefaults.standard.setValue(value, forKey: "wakeup")
                })
                <<< TimeRow(){
                    $0.title = "Я ложусь спать в"
                    $0.value = dateAsleep
                }.onChange({value in
                    UserDefaults.standard.removeObject(forKey: "asleep")
                    UserDefaults.standard.setValue(value, forKey: "asleep")
                })
                <<< TimeRow(){
                    $0.title = "Интервал между уведомлениями"
                    $0.value = dateInterval
                }.onChange({value in
                    UserDefaults.standard.removeObject(forKey: "interval")
                    UserDefaults.standard.setValue(value, forKey: "interval")
                })
            
            +++ Section()
                <<< ButtonRow(){
                    $0.title = "Готово"
                }.onCellSelection({_,_ in
                    
                    let layout = UICollectionViewFlowLayout()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = MainVC(collectionViewLayout: layout)
                    
                })
    }
    
}
