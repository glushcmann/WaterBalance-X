//
//  SetupWeightVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import RealmSwift

class SetupWeightVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    private let cellID = "cellID"
    private let defaultCellID = "defaultCellID"
    
    let headerTitle = "Ваш вес"
    let footerTitle = "Сообщите нам ваш вес, он необходим для того, чтобы предложить подходящее для вас количество воды в день."
    
    let realm = try! Realm()
    
    var weight: [Int] = [0]
    var numberPicker = UIPickerView()
    var toolBar = UIToolbar()
    var selectedIndex = 0
    
    func addToArray() {
        for i in 1...200 {
            weight.append(i)
        }
    }
    
    func showNumberPicker() {
        
        addToArray()
        
        numberPicker = UIPickerView.init()
        numberPicker.autoresizingMask = .flexibleWidth

        numberPicker.dataSource = self
        numberPicker.delegate = self
        
        numberPicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(numberPicker)

        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
        
    }

    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        numberPicker.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.register(TextFieldCell.self, forCellReuseIdentifier: cellID)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellID)
        
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
            
            cell.textField.text = String(weight[numberPicker.selectedRow(inComponent: 0)])
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
            selectedIndex = indexPath.row
            onDoneButtonClick()
            showNumberPicker()
        } else {
            self.navigationController?.pushViewController(PersonalGoalVC(style: .insetGrouped), animated: true)
        }
        
    }
}

extension SetupWeightVC {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weight.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = String(weight[row])
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let indexPath = IndexPath(row: selectedIndex, section:0)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }

}
