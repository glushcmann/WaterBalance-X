//
//  TextFieldCell.swift
//  WaterBalance X
//
//  Created by Никита on 02.08.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textField)
        
        addConstraintWithFormat("H:|[v0]|", views: textField)
        addConstraintWithFormat("V:|[v0]|", views: textField)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
