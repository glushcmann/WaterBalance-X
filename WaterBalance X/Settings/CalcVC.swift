//
//  CalcVC.swift
//  WaterBalance X
//
//  Created by Никита on 20.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class CalcVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let cellID = "cellID"
    
    let header = ["Ваш вес", "Предлагаемое количество воды"]
    let footer = "Значение носит рекомендательный характер. Никогда не помешает проконсультироваться с вашим врачом относительно подходящего для вас количества воды."
    
    var weight: [Int] = [0]
    var numberPicker = UIPickerView()
    var toolBar = UIToolbar()
    var selectedIndex = IndexPath(row: 0, section: 0)

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
        
        numberPicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 415, width: UIScreen.main.bounds.size.width, height: 270)
        self.view.addSubview(numberPicker)

        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 415, width: UIScreen.main.bounds.size.width, height: 50))
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
        navigationItem.title = "Расчет воды"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
}

extension CalcVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return header[0]
        } else {
            return header[1]
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        if section == 1 {
            return footer
        } else {
            return nil
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(String(weight[numberPicker.selectedRow(inComponent: 0)])) кг"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .systemBlue
        } else {
            cell.textLabel?.text = "2000 мл"
            cell.textLabel?.textAlignment = .center
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            onDoneButtonClick()
            showNumberPicker()
        }
        
    }
}

extension CalcVC {
    
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
        tableView.reloadRows(at: [selectedIndex], with: UITableView.RowAnimation.none)
    }

}
