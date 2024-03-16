//
//  StudySetupViewsFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 16.03.2024.
//

import UIKit

final class StudySetupViewsFactory {
    static func createOptionsTableView() -> UITableView {
        let tableView = UITableView()
        tableView.alpha = 0
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DefaultCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .textFieldInner
        tableView.separatorColor = .moduleDescription
        tableView.tableFooterView = UIView()
        return tableView
    }
}
