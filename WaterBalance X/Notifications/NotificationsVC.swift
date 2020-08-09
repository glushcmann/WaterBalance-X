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
    
    //TODO: добавить выбор времени внутрь алерта
    
//    func showAlert() {
//
//        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
//
//        alert.view.addSubview(datePicker)
//        alert.addTextField { (textField) in
//            self.showDatePicker()
//            textField.inputView = self.datePicker
//            textField.inputAccessoryView = self.toolBar
//        }
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
//            if textField?.text != ""{
//                print("Text field: \(String(describing: textField?.text!))")
//            }
//        }))
//
//        self.present(alert, animated: true, completion: nil)
//
//    }
    
    func showDatePicker() {
        
        datePicker = UIDatePicker.init()

        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .time

        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 420, width: UIScreen.main.bounds.size.width, height: 420)
        self.view.addSubview(datePicker)

        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 420, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
        
    }

    @objc func dateChanged(_ sender: UIDatePicker?) {
        let indexPath = IndexPath(row: selectedIndex, section:1)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }

    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Напоминания"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(close))
        
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
        
        let defaultCell = self.tableView.dequeueReusableCell(withIdentifier: defaultCellID, for: indexPath)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TextLabelCell
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "H:mm"
        
        switch indexPath.section {
        case 0:
            defaultCell.textLabel?.text = data[0][0]
            defaultCell.accessoryView = switchView
            defaultCell.selectionStyle = .none
            return defaultCell
        case 1:
            cell.textLabel?.text = data[1][indexPath.row]
            cell.textField.text = dateFormatter.string(from: datePicker.date)
            return cell
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
            onDoneButtonClick()
            showDatePicker()
//            showAlert()
        }
        
    }
}
