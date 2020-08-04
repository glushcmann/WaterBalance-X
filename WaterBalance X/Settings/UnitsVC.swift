//
//  UnitsVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class UnitsVC: UITableViewController {
    
    let cellID = "cellID"
    
    let header = ["Вода", "Вес"]
    let data = [["мл", "унции"],
                ["кг", "фунты"]
    ]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Единицы измерения"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
}

extension UnitsVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return header[0]
        } else {
            return header[1]
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.text = data[0][0]
            } else {
                cell.textLabel?.text = data[0][1]
            }
        case 1:
            if indexPath.row == 0 {
                cell.textLabel?.text = data[1][0]
            } else {
                cell.textLabel?.text = data[1][1]
            }
        default:
            break
        }
        
        return cell
        
    }
}
