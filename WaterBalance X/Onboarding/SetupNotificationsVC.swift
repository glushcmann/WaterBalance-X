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
    
    let defaults = UserDefaults.standard
    
    var datePicker = UIDatePicker()
    var toolBar = UIToolbar()
    let dateFormatter = DateFormatter()
    var selectedIndex = 0
    
    func showAlert() {
        
        let title = "Вы не настроили уведомления, можно сделать это позже "
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.modalPresentationStyle = .popover
        
        let okAction = UIAlertAction(title: "Добавить потом", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.navigationController?.pushViewController(MainVC(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Добавить сейчас", style: UIAlertAction.Style.default)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion:{
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }
    
    func showPickerInAlert() {
        
        let title = ""
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.modalPresentationStyle = .popover

        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 260)
        alert.view.addConstraint(height)
        
        let pickerFrame: CGRect = CGRect(x: 20, y: 0, width: alert.view.bounds.width - 40, height: 260)
        datePicker = UIDatePicker.init(frame: pickerFrame)
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .time
    
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        
        alert.view.addSubview(datePicker)
        self.present(alert, animated: true, completion:{
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }
    
    @objc func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func dateChanged(_ sender: UIDatePicker?) {
        
        let indexPath = IndexPath(row: selectedIndex, section:0)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        
        switch selectedIndex {
        case 0:
            defaults.removeObject(forKey: "wakeup")
            defaults.set(dateFormatter.string(from: datePicker.date), forKey: "wakeup")
        case 1:
            defaults.removeObject(forKey: "asleep")
            defaults.set(dateFormatter.string(from: datePicker.date), forKey: "asleep")
        case 2:
            defaults.removeObject(forKey: "interval")
            defaults.set(dateFormatter.string(from: datePicker.date), forKey: "interval")
        default:
            return
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellID)
        
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
        
        let buttonCell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        var defaultCell = self.tableView.dequeueReusableCell(withIdentifier: defaultCellID, for: indexPath)
        defaultCell = UITableViewCell(style: .value1, reuseIdentifier: defaultCellID)
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "H:mm"
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
                defaultCell.textLabel?.text = "Я просыпаюсь в:"
                defaultCell.detailTextLabel?.text = dateFormatter.string(from: datePicker.date)
            case 1:
                defaultCell.textLabel?.text = "Я ложусь спать в:"
                defaultCell.detailTextLabel?.text = dateFormatter.string(from: datePicker.date)
            case 2:
                defaultCell.textLabel?.text = "Интервал между уведомлениями:"
                defaultCell.detailTextLabel?.text = dateFormatter.string(from: datePicker.date)
            default:
                break
            }
            
            return defaultCell
            
        } else {
            
            buttonCell.textLabel?.text = "Готово"
            buttonCell.textLabel?.textColor = .white
            buttonCell.textLabel?.textAlignment = .center
            buttonCell.backgroundColor = .systemBlue
            buttonCell.selectionStyle = .none
            return buttonCell
            
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
            
            selectedIndex = indexPath.row
            showPickerInAlert()
            
        } else if (indexPath.section == 1) && (defaults.string(forKey: "wakeup") != nil) && (defaults.string(forKey: "asleep") != nil) && (defaults.string(forKey: "interval") != nil) {
            
            print(defaults.string(forKey: "wakeup")!)
            print(defaults.string(forKey: "asleep")!)
            print(defaults.string(forKey: "interval")!)
            
            self.navigationController?.pushViewController(MainVC(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
            
        } else {
            showAlert()
        }
        
    }
}
