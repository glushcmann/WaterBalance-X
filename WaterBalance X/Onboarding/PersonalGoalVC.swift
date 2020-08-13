//
//  PersonalGoalVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class PersonalGoalVC: UITableViewController {
    
    private let cellID = "cellID"
    
    let headerTitle = "Рекомендуемый объем воды"
    let footerTitle = "Эта число носит рекомендательный характер. Желательно проконсультироваться с вашим врачом."
    
    let defaults = UserDefaults.standard
    var goal = 0
    
    func calcGoal() {
        
        let weight = defaults.integer(forKey: "weight")
        let gender = defaults.string(forKey: "gender")
        let intensity = defaults.string(forKey: "intensity")
        
        switch gender {
        case "male":
            switch intensity {
            case "low":
                goal = 30 * weight
            case "medium":
                goal = 35 * weight
            case "high":
                goal = 40 * weight
            default:
                return
            }
        case "female":
            switch intensity {
            case "low":
                goal = 25 * weight
            case "medium":
                goal = 30 * weight
            case "high":
                goal = 35 * weight
            default:
                return
            }
        default:
            return
        }
        
        defaults.removeObject(forKey: "goal")
        defaults.set(goal, forKey: "goal")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcGoal()
        self.tableView.isScrollEnabled = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
}

extension PersonalGoalVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(goal) мл"
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
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
            return
        } else {
            self.navigationController?.pushViewController(SetupNotificationsVC(style: .insetGrouped), animated: true)
        }
    }
    
}
