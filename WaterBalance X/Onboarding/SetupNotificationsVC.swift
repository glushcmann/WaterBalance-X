//
//  SetupNotificationsVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class SetupNotificationsVC: UITableViewController {
    
    private let cellID = "cellID"
    private let defaultCellID = "defaultCellID"
    
    let headerTitle = "Последний шаг. Настройте напоминания"
    
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
    }

    @objc func donedatePicker(cell: TextFieldCell){

        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeStyle = .medium
        formatter.amSymbol = "утра"
        formatter.pmSymbol = "вечера"
        cell.textField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }

    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(TextLabelCell.self, forCellReuseIdentifier: cellID)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellID)
        
        datePicker.datePickerMode = .time
    }
    
}

extension SetupNotificationsVC {
    
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
        
        let defaultCell = self.tableView.dequeueReusableCell(withIdentifier: defaultCellID, for: indexPath)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TextLabelCell
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
//                cell.textLabel?.text = "Я просыпаюсь в:"
//                cell.detailTextLabel?.text = "10:00"
                cell.label.text = "Я просыпаюсь в:"
                cell.textField.text = "10:00"
                cell.textField.inputAccessoryView = toolbar
                cell.textField.inputView = datePicker
                
                toolbar.sizeToFit()
                let doneButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(donedatePicker));
                let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelDatePicker));

                toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
            case 1:
                cell.textLabel?.text = "Я ложусь спать в:"
                cell.detailTextLabel?.text = "22:00"
            case 2:
                cell.textLabel?.text = "Интервал между уведомлениями:"
                cell.detailTextLabel?.text = "2:00"
            default:
                break
            }
            return cell
            
        } else {
            
            defaultCell.textLabel?.text = "Готово"
            defaultCell.textLabel?.textColor = .white
            defaultCell.textLabel?.textAlignment = .center
            defaultCell.backgroundColor = .systemBlue
            return defaultCell
            
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
            return
        } else {
            self.navigationController?.pushViewController(MainVC(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
        }
    }
    
}
