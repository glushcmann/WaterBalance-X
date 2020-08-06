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
    
    var datePicker = UIDatePicker()
    var toolBar = UIToolbar()
    let dateFormatter = DateFormatter()
    
    var selectedIndex = 0
    
    func showDatePicker() {
        datePicker = UIDatePicker.init()

        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .time

        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)

        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }

    @objc func dateChanged(_ sender: UIDatePicker?) {
        let indexPath = IndexPath(row: selectedIndex, section:0)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }

    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.register(TextLabelCell.self, forCellReuseIdentifier: cellID)
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
        
        let defaultCell = self.tableView.dequeueReusableCell(withIdentifier: defaultCellID, for: indexPath)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TextLabelCell
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "H:mm"
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
                cell.label.text = "Я просыпаюсь в:"
                cell.textField.text = dateFormatter.string(from: datePicker.date)
            case 1:
                cell.label.text = "Я ложусь спать в:"
                cell.textField.text = dateFormatter.string(from: datePicker.date)
            case 2:
                cell.label.text = "Интервал между уведомлениями:"
                cell.textField.text = dateFormatter.string(from: datePicker.date)
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
            selectedIndex = indexPath.row
            onDoneButtonClick()
            showDatePicker()
        } else {
            self.navigationController?.pushViewController(MainVC(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
        }
    }
    
}
