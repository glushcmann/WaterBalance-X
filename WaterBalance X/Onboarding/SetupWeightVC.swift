//
//  SetupWeightVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class SetupWeightVC: UITableViewController {
    
    private let cellID = "cellID"
    private let textFieldCellID = "textFieldCellID"
    
    let headerTitle = "Ваш вес"
    let footerTitle = "Сообщите нам ваш вес, он необходим для того, чтобы предложить подходящее для вас количество воды в день."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
}

extension SetupWeightVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellID)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "Введите вес:"
            cell.detailTextLabel?.text = "1000"
        } else {
            cell.textLabel?.text = "Далее"
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .systemBlue
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        var title: String?
        
        if section == 1 {
            title = footerTitle
        }
        
        return title
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title: String?
        
        if section == 0 {
            title = headerTitle
        }
        
        return title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
        } else {
            self.navigationController?.pushViewController(PersonalGoalVC(style: .insetGrouped), animated: true)
        }
    }
    
}
