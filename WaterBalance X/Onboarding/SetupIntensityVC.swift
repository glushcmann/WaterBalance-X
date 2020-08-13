//
//  SetupIntensityVC.swift
//  WaterBalance X
//
//  Created by Никита on 13.08.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class SetupIntensityVC: UITableViewController {
    
    private let cellID = "cellID"
    
    let headerTitle = "Укажите интенсивность физических нагрузок"
    let data = ["Низкая","Средняя","Высокая"]
    
    let defaults = UserDefaults.standard
    
    func showAlert() {
        
        let title = "Выбирите интенсивность физических нагрузок чтобы продолжить"
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.modalPresentationStyle = .popover
        
        let okAction = UIAlertAction(title: "Хорошо", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion:{
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }
        
    @objc func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
}

extension SetupIntensityVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
             return 3
         } else {
             return 1
         }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if indexPath.section == 0 {
            
            cell.textLabel?.text = data[indexPath.row]
            cell.textLabel?.textAlignment = .center
            return cell
            
        } else {
            
            cell.textLabel?.text = "Далее"
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .systemBlue
            cell.selectionStyle = .none
            return cell
            
        }
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
            switch indexPath.row {
            case 0:
                defaults.removeObject(forKey: "intensity")
                defaults.set("low", forKey: "intensity")
            case 1:
                defaults.removeObject(forKey: "intensity")
                defaults.set("medium", forKey: "intensity")
            case 2:
                defaults.removeObject(forKey: "intensity")
                defaults.set("high", forKey: "intensity")
            default:
                return
            }
        } else {
            
            if defaults.string(forKey: "intensity") != nil {
                print(defaults.string(forKey: "intensity")!)
                self.navigationController?.pushViewController(PersonalGoalVC(style: .insetGrouped), animated: true)
            } else {
                showAlert()
            }
        }
        
    }
}
