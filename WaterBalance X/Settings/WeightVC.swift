//
//  WeightVC.swift
//  WaterBalance X
//
//  Created by Никита on 23.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class WeightVC: UITableViewController {
    
    let cellID = "cellID"
    
//    let textView: UITextField = {
//        let text = UITextField(frame: .zero)
//        return text
//    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Вес"
        view.backgroundColor = .systemGroupedBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
    
}

extension WeightVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "100 кг"
            cell.textLabel?.textAlignment = .center
//            cell.accessoryView = textView
//            cell.accessoryView?.backgroundColor = .red
        } else {
            cell.textLabel?.text = "Изменить"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .systemBlue
        }
        
        return cell
        
    }
    
}
