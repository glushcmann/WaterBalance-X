//
//  SetupSexVC.swift
//  WaterBalance X
//
//  Created by Никита on 13.08.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class SetupGenderVC: UITableViewController {
    
    private let cellID = "cellID"
    
    let headerTitle = "Укажите пол"
    let data = ["Мужской","Женский"]
    
    let defaults = UserDefaults.standard
    
    func showAlert() {
        
        let title = "Выбирите пол чтобы продолжить"
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

extension SetupGenderVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
         } else {
             return 1
         }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if indexPath.section == 0 {
            
            cell.textLabel?.text = data[indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .blue
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
            
            if indexPath.row == 0 {
                defaults.removeObject(forKey: "gender")
                defaults.set("male", forKey: "gender")
            } else {
                defaults.removeObject(forKey: "gender")
                defaults.set("female", forKey: "gender")
            }
            
        } else {
            if defaults.string(forKey: "gender") != nil {
                print(defaults.string(forKey: "gender")!)
                self.navigationController?.pushViewController(SetupWeightVC(style: .insetGrouped), animated: true)
            } else {
                showAlert()
            }
        }
    }
}

