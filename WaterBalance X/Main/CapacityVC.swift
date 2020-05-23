//
//  CapacityVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import Eureka
import PanModal

class CapacityVC: FormViewController, PanModalPresentable {
    
    var panScrollable: UIScrollView?
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(450)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        form
            +++ Section("Добавьте обьем выпитой воды")
                <<< LabelRow(){
                    $0.title = "100"
                }
                <<< LabelRow(){
                    $0.title = "200"
                }
                <<< LabelRow(){
                    $0.title = "300"
                }
                <<< LabelRow(){
                    $0.title = "400"
                }
                <<< LabelRow(){
                    $0.title = "500"
                }
                <<< LabelRow(){
                    $0.title = "600"
                }

    }
    
}
