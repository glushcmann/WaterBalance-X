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
    
    var weight: [Int] = {
        var array = [Int]()
        for i in 1...200 {
            array.append(i)
        }
        return array
    }()
    
    var numberPicker = UIPickerView()
    var toolBar = UIToolbar()
    var selectedIndex = IndexPath(row: 0, section: 0)

    func showPickerInAlert() {
        
        let title = ""
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.modalPresentationStyle = .popover

        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 260)
        alert.view.addConstraint(height)
        
        let pickerFrame: CGRect = CGRect(x: 17, y: 0, width: alert.view.bounds.width - 34, height: 260)
        numberPicker = UIPickerView.init(frame: pickerFrame)
        numberPicker.autoresizingMask = .flexibleWidth

        numberPicker.dataSource = self
        numberPicker.delegate = self
        numberPicker.selectRow(69, inComponent: 0, animated: true)
        
        alert.view.addSubview(numberPicker)
        self.present(alert, animated: true, completion:{
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }
    
    @objc func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        numberPicker.dataSource = self
        numberPicker.delegate = self
        numberPicker.selectRow(69, inComponent: 0, animated: true)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Расчет воды"
        
        self.tableView.isScrollEnabled = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
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
            cell.selectionStyle = .none
        } else {
            cell.textLabel?.text = "2000 мл"
            cell.textLabel?.textAlignment = .center
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            showPickerInAlert()
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
