//
//  TimePicker.swift
//  WaterBalance X
//
//  Created by Никита on 05.08.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

//import UIKit
//
//class TimePicker: UIViewController {
//    
//    let txtDatePicker = UITextField()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        showDatePicker()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func showDatePicker(){
//        //Formate Date
//        self.datePickerMode = .time
//
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
//        txtDatePicker.inputAccessoryView = toolbar
//        txtDatePicker.inputView = self
//
//    }
//    
//    @objc func donedatePicker(){
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM/yyyy"
//        txtDatePicker.text = formatter.string(from: self.date)
//        self.endEditing(true)
//    }
//
//    @objc func cancelDatePicker(){
//        self.endEditing(true)
//    }
//    
//}
