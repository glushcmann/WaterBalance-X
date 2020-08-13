//
//  SettingsVC.swift
//  WaterBalance X
//
//  Created by Никита on 20.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
    let cellID = "cellID"
    
    var header = ["Моя информация", "Настройки", "Поддержка"]
    
    var footer = ["Приложение будет сохранять данные в Apple Health. Узнайте истинный обьем потребляемой Вами воды и связанную с этим статистику."]
    
    var data = [["Обновиться до полной версии"],
                ["Мое ежедневное потребление", "Калькулятор воды"],
                ["Единицы измерения", "Виджет"],
                ["Apple Health"],
                ["Нравится приложение? Оцените его!"]
    ]
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Настройки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(close))
        
        self.tableView.isScrollEnabled = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
    
}

extension SettingsVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rows = 0
        
        if section == 1 || section == 2 {
            rows = 2
        } else {
            rows = 1
        }
        
        return rows
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title: String?
        
        switch section {
        case 1:
            title = header[0]
        case 2:
            title = header[1]
        case 4:
            title = header[2]
        default:
            title = nil
        }
        
        return title
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        var text: String?
        
        if section == 3 {
            text = footer[0]
        } else {
            text = nil
        }
        
        return text
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = data[0][0]
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .systemBlue
            cell.accessoryType = .none
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = data[1][0]
            case 1:
                cell.textLabel?.text = data[1][1]
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = data[2][0]
            case 1:
                cell.textLabel?.text = data[2][1]
            default:
                break
            }
        case 3:
            cell.textLabel?.text = data[3][0]
        case 4:
            cell.textLabel?.text = data[4][0]
        default:
            break
        }

        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 1:
            if indexPath.row == 0 {
                let vc = WeightVC(style: .insetGrouped)
                self.show(vc, sender: self)
            } else {
                let vc = CalcVC(style: .insetGrouped)
                self.show(vc, sender: self)
            }
        case 2:
            if indexPath.row == 0 {
                let vc = UnitsVC(style: .insetGrouped)
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "Настройки", style: .plain, target: self, action: #selector(close))
                self.show(vc, sender: self)
            }
        default:
            break
        }
        
    }
    
}
