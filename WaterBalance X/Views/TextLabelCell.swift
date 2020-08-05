//
//  TextLabelCell.swift
//  WaterBalance X
//
//  Created by Никита on 05.08.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class TextLabelCell: UITableViewCell {

    let textField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.textAlignment = .right
        return textField
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: .value1, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(textField)
        contentView.addSubview(label)

        addConstraintWithFormat("H:|-20-[v0]-15-[v1]-20-|", views: label, textField)
        addConstraintWithFormat("V:|-10-[v0]-10-|", views: label)
        addConstraintWithFormat("V:|-10-[v0]-10-|", views: textField)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

