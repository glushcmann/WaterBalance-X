//
//  NotificationsVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class NotificationsVC: UITableViewController {
    
    let cellID = "cellID"
    
    let data = [["Уведомления"],
                ["Я просыпаюсь в", "Я ложусь спать в", "Интервал между уведомлениями"],
                ["Звук оповещения"]
    ]
    
    let footer = ["Звук оповещения"]

    let switchView: UISwitch = {
        let sw = UISwitch()
        sw.setOn(false, animated: true)
        sw.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        return sw
    }()
    
    @objc func switchChanged(_ sender : UISwitch!){
          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Напоминания"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(close))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
}

extension NotificationsVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return 3
        } else {
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        let text: String?
        
        if section == 1 {
            text = footer[0]
        } else {
            text = nil
        }
        
        return text
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = data[0][0]
            cell.accessoryView = switchView
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = data[1][0]
            case 1:
                cell.textLabel?.text = data[1][1]
            case 2:
                cell.textLabel?.text = data[1][2]
            default:
                break
            }
        case 2:
            cell.textLabel?.text = data[2][0]
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }
        
        return cell
        
    }
}
