//
//  SetupWeightVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import RealmSwift

class SetupWeightVC: UITableViewController {
    
    private let cellID = "cellID"
    private let defaultCellID = "defaultCellID"
    
    let headerTitle = "Ваш вес"
    let footerTitle = "Сообщите нам ваш вес, он необходим для того, чтобы предложить подходящее для вас количество воды в день."
    

    
    let realm = try! Realm()
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.register(TextFieldCell.self, forCellReuseIdentifier: cellID)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellID)
        
//        let result = realm.objects(User.self)
        let user = User()
        user.weight = 80
        user.goal = user.weight * 40
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
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
        
        let defaultCell = self.tableView.dequeueReusableCell(withIdentifier: defaultCellID, for: indexPath)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TextFieldCell
        
        if indexPath.section == 0 {
            
            cell.textField.text = "fddf"
            
            return cell
            
        } else {
            
            defaultCell.textLabel?.text = "Далее"
            defaultCell.textLabel?.textColor = .white
            defaultCell.textLabel?.textAlignment = .center
            defaultCell.backgroundColor = .systemBlue
            return defaultCell
            
        }
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
