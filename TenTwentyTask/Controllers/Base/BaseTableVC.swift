//
//  BaseTableVC.swift
//  TenTwentyTask
//
//  Created by usama on 13/03/2022.
//

import UIKit

class BaseTableVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }

    func initTableView() {
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.tableFooterView =  UIView()
    }
}
