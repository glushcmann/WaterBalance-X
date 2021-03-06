//
//  NotificationsVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class NotificationsVC: UITableViewController {
    
    let cellID = "cellID"
    let defaultCellID = "defaultCellID"
    
    let defaults = UserDefaults.standard
    
    var datePicker = UIDatePicker()
    var toolBar = UIToolbar()
    let dateFormatter = DateFormatter()
    var selectedIndex = 0
    
    let data = [["Уведомления"],
                ["Я просыпаюсь в", "Я ложусь спать в", "Интервал между уведомлениями"],
                ["Звук оповещения"]
    ]
    
    let footer = ["Среднее количество воды для каждого приема пищи: 200 мл"]

    let switchView: UISwitch = {
        let sw = UISwitch()
        sw.setOn(false, animated: true)
        sw.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        return sw
    }()
    
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
        let indexPath = IndexPath(row: selectedIndex, section:1)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        dateFormatter.dateFormat = "H:mm"
        let indexPath = IndexPath(row: selectedIndex, section:1)
        
        switch selectedIndex {
        case 0:
            let wakeup = defaults.string(forKey: "wakeup")!
            datePicker.date = dateFormatter.date(from: wakeup)!
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        case 1:
            let asleep = defaults.string(forKey: "asleep")!
            datePicker.date = dateFormatter.date(from: asleep)!
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        default:
            return
        }
   
//        for cell in 0...2 {
//
//            let indexPath = IndexPath(row: cell, section:1)
//
//            switch cell {
//            case 0:
//                let wakeup = defaults.string(forKey: "wakeup")!
//                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = wakeup
//                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
//            case 1:
//                let asleep = defaults.string(forKey: "asleep")!
//                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = asleep
//                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
//            case 2:
//                let interval = defaults.string(forKey: "interval")!
//                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = interval
//                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
//            default:
//                return
//            }
//        }
        
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Напоминания"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(close))
        
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellID)
        tableView.register(TextLabelCell.self, forCellReuseIdentifier: cellID)
        
    }
}

extension NotificationsVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return 3
        } else {
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        let text: String?
        
        if section == 1 {
            text = footer[0]
        } else {
            text = nil
        }
        
        return text
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var defaultCell = self.tableView.dequeueReusableCell(withIdentifier: defaultCellID, for: indexPath)
        defaultCell = UITableViewCell(style: .value1, reuseIdentifier: defaultCellID)
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "H:mm"
        
        switch indexPath.section {
        case 0:
            defaultCell.textLabel?.text = data[0][0]
            defaultCell.accessoryView = switchView
            defaultCell.selectionStyle = .none
            return defaultCell
        case 1:
            defaultCell.textLabel?.text = data[1][indexPath.row]
            defaultCell.detailTextLabel?.text = dateFormatter.string(from: datePicker.date)
            return defaultCell
        case 2:
            defaultCell.textLabel?.text = data[2][0]
            defaultCell.accessoryType = .disclosureIndicator
            return defaultCell
        default:
            return defaultCell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            selectedIndex = indexPath.row
            showPickerInAlert()
        }
        
    }
}
