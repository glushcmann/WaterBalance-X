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
    
    let headerTitle = "Укажите вес"
    let footerTitle = "Сообщите нам ваш вес, он необходим для того, чтобы предложить подходящее для вас количество воды в день."
    
    let defaults = UserDefaults.standard
    
    var weight: [Int] = {
        var array = [Int]()
        for i in 1...200 {
            array.append(i)
        }
        return array
    }()
    
    var numberPicker = UIPickerView()
    var toolBar = UIToolbar()
    var selectedIndex = 0
    
    func showPickerInAlert() {
        
        let title = ""
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.modalPresentationStyle = .popover

        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 260)
        alert.view.addConstraint(height)
        
        let pickerFrame: CGRect = CGRect(x: 20, y: 0, width: alert.view.bounds.width - 40, height: 260)
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
        
        defaults.removeObject(forKey: "weight")
        defaults.set(70, forKey: "weight")
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
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
        
        let defaultCell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if indexPath.section == 0 {
            defaultCell.textLabel?.text = "\(String(weight[numberPicker.selectedRow(inComponent: 0)])) кг"
            defaultCell.selectionStyle = .none
            defaultCell.textLabel?.textAlignment = .center
        } else {
            
            defaultCell.textLabel?.text = "Далее"
            defaultCell.textLabel?.textColor = .white
            defaultCell.textLabel?.textAlignment = .center
            defaultCell.backgroundColor = .systemBlue
            
        }
        
        return defaultCell
        
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
            showPickerInAlert()
        } else {
            print(defaults.integer(forKey: "weight"))
            self.navigationController?.pushViewController(SetupIntensityVC(style: .insetGrouped), animated: true)
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
        
        defaults.removeObject(forKey: "weight")
        defaults.set(row + 1, forKey: "weight")
        
    }

}
