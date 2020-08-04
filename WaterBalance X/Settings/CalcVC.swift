//
//  CalcVC.swift
//  WaterBalance X
//
//  Created by Никита on 20.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class CalcVC: UITableViewController {
    
    let header = ["Ваш вес", "Предлагаемое количество воды"]
    let footer = "Значение носит рекомендательный характер. Никогда не помешает проконсультироваться с вашим врачом относительно подходящего для вас количества воды."
    
    let cellID = "cellID"

    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Расчет воды"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
}

extension CalcVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return header[0]
        } else {
            return header[1]
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        if section == 1 {
            return footer
        } else {
            return nil
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "100 кг"
            cell.textLabel?.textAlignment = .center
        } else {
            cell.textLabel?.text = "2000 мл"
            cell.textLabel?.textAlignment = .center
        }
        
        return cell
        
    }
}
