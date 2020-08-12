//
//  WeightVC.swift
//  WaterBalance X
//
//  Created by Никита on 23.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class WeightVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let cellID = "cellID"
    
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
    
    func showPickerInActionSheet() {
        
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
        
        alert.view.addSubview(numberPicker)
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
        navigationItem.title = "Вес"
        view.backgroundColor = .systemGroupedBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
}

extension WeightVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(String(weight[numberPicker.selectedRow(inComponent: 0)])) кг"
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
        } else {
            cell.textLabel?.text = "Изменить"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .systemBlue
            cell.selectionStyle = .none
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showPickerInActionSheet()
    }
    
}


extension WeightVC {
    
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
