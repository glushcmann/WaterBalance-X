//
//  SecondOpeningVC.swift
//  WaterBalance X
//
//  Created by Никита on 24.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Lottie

class SecondOpeningVC: UIViewController {
    
    let upperLabel: UILabel = {
        let label = UILabel()
        label.text = "Получайте напоминания"
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    let animationView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("notification-bell")
        return view
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Можно настроить расопорядок дня и интервал напоминаний"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Дальше", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 30
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped() {
        self.navigationController?.pushViewController(SetupWeightVC(), animated: true)
    }
    
    func setupViews() {
        
        view.addSubview(upperLabel)
        view.addSubview(animationView)
        view.addSubview(bottomLabel)
        view.addSubview(button)
        
        addConstraintWithFormat("H:|-20-[v0]-20-|", views: upperLabel)
        addConstraintWithFormat("H:|-20-[v0]-20-|", views: animationView)
        addConstraintWithFormat("H:|-20-[v0]-20-|", views: bottomLabel)
        addConstraintWithFormat("H:|-40-[v0]-40-|", views: button)
        
        addConstraintWithFormat("V:|-100-[v0(100)]-80-[v1(300)]", views: upperLabel, animationView)
        addConstraintWithFormat("V:[v0(100)]-40-[v1(60)]-50-|", views: bottomLabel, button)
        
    }
    
    func startAnimation() {
        animationView.play()
        animationView.loopMode = .loop
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupViews()
        startAnimation()
    }
    
}
