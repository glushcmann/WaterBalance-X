//
//  CapacityVC.swift
//  WaterBalance X
//
//  Created by Никита on 21.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
//import Eureka
import PanModal
//
//class CapacityVC: FormViewController, PanModalPresentable {
//
//    var panScrollable: UIScrollView?
//    var longFormHeight: PanModalHeight {
//        return .maxHeightWithTopInset(450)
//    }
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//        form
//            +++ Section("Добавьте обьем выпитой воды")
//                <<< LabelRow(){
//                    $0.title = "100"
//                }
//                <<< LabelRow(){
//                    $0.title = "200"
//                }
//                <<< LabelRow(){
//                    $0.title = "300"
//                }
//                <<< LabelRow(){
//                    $0.title = "400"
//                }
//                <<< LabelRow(){
//                    $0.title = "500"
//                }
//                <<< LabelRow(){
//                    $0.title = "600"
//                }
//
//    }
//
//}

class CapacityVC: UITableViewController, PanModalPresentable {
    
    var panScrollable: UIScrollView?
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(460)
    }
    
    private let cellID = "cellID"
    
    let headerTitle = "Добавьте обьем выпитой воды"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
}

extension CapacityVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "100"
            cell.textLabel?.textAlignment = .center
        case 1:
            cell.textLabel?.text = "200"
            cell.textLabel?.textAlignment = .center
        case 2:
            cell.textLabel?.text = "300"
            cell.textLabel?.textAlignment = .center
        case 3:
            cell.textLabel?.text = "400"
            cell.textLabel?.textAlignment = .center
        case 4:
            cell.textLabel?.text = "500"
            cell.textLabel?.textAlignment = .center
        case 5:
            cell.textLabel?.text = "600"
            cell.textLabel?.textAlignment = .center
        default:
            break
        }
        
        return cell
    }
}
