//
//  ConstraintsExtension.swift
//  WaterBalance X
//
//  Created by Никита on 20.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addConstraintWithFormat(_ format : String, views : UIView...) {

        var viewsDictionary = [String : UIView]()

        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))

    }
}

extension UITableViewCell {
    
    func addConstraintWithFormat(_ format : String, views : UIView...) {

        var viewsDictionary = [String : UIView]()

        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))

    }
}
