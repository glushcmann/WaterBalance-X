//
//  ViewController.swift
//  WaterBalance X
//
//  Created by Никита on 20.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import PanModal
import Bond
import ReactiveKit

class MainVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate {
    
    let upperLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня мне еще нужно выпить:"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        let goal: Int = UserDefaults.standard.integer(forKey: "goal")
        label.text = "\(goal) мл"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .large)
        button.setImage(UIImage(systemName: "gear", withConfiguration: largeConfig), for: .normal)
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let notifyButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .large)
        button.setImage(UIImage(systemName: "bell", withConfiguration: largeConfig), for: .normal)
        button.addTarget(self, action: #selector(notifyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func addButtonTapped() {
        self.presentPanModal(CapacityVC(style: .insetGrouped))
    }
    
    @objc func settingsButtonTapped() {
//        let vc = SettingsVC()
        let vc = SettingsVC(style: .insetGrouped)
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc func notifyButtonTapped() {
        let vc = NotificationsVC(style: .insetGrouped)
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    func setupViews() {
        
        view.addSubview(upperLabel)
        view.addSubview(goalLabel)
        view.addSubview(addButton)
        view.addSubview(settingsButton)
        view.addSubview(notifyButton)
        
        addConstraintWithFormat("H:|-20-[v0]-20-|", views: upperLabel)
        addConstraintWithFormat("H:|-20-[v0]-20-|", views: goalLabel)
        addConstraintWithFormat("H:|-40-[v0]-40-|", views: addButton)
        addConstraintWithFormat("H:[v0(30)]-20-|", views: settingsButton)
        addConstraintWithFormat("H:|-20-[v0(30)]", views: notifyButton)
        
        addConstraintWithFormat("V:|-150-[v0(50)]-10-[v1(30)]", views: upperLabel, goalLabel)
        addConstraintWithFormat("V:[v0(50)]-70-[v1(30)]-40-|", views: addButton, settingsButton)
        addConstraintWithFormat("V:[v0(30)]-40-|", views: notifyButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        setupViews()
        
        //MARK: dont forget to uncomment this line
//        UserDefaults.standard.set(true, forKey: "hasLaunched")
    }


}

