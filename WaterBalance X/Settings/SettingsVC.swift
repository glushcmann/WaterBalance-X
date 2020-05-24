//
//  SettingsVC.swift
//  WaterBalance X
//
//  Created by Никита on 20.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Eureka

class SettingsVC: FormViewController {
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Настройки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(close))
        
        form
        +++ Section()
            <<< ButtonRow(){
                $0.title = "Обновиться до полной версии"
            }
    
        +++ Section("Моя информация")
            <<< LabelRow(){
                $0.title = "Мое ежедневное потребление"
            }.onCellSelection {_,_ in
                self.navigationController?.pushViewController(WeightVC(), animated: true)
            }
            <<< LabelRow(){
                $0.title = "Калькулятор воды"
            }.onCellSelection {_,_ in
                self.navigationController?.pushViewController(CalcVC(), animated: true)
            }
    
        +++ Section("Настройки")
            <<< LabelRow(){
                $0.title = "Единицы измерения"
            }.onCellSelection {_,_ in
                self.navigationController?.pushViewController(UnitsVC(), animated: true)
            }
            <<< LabelRow(){
                $0.title = "Виджет"
            }
    
        +++ Section(footer: "Приложение будет сохранять данные в Apple Health. Узнайте истинный обьем потребляемой Вами воды и связанную с этим статистику.")
            <<< LabelRow(){
                $0.title = "Apple Health"
            }
    
        +++ Section("Поддержка")
            <<< LabelRow(){
                $0.title = "Нравится приложение? Оцените его!"
            }

    }
}
