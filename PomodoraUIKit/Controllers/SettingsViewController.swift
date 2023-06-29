//
//  SettingsViewController.swift
//  PomodoraUIKit
//
//  Created by Али  on 06.05.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    var focusBreakArr = ["Focus time", "Break time"]
    var editButton: UIBarButtonItem?

        
    
    lazy private var table: UITableView = {
        let table = UITableView()
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.backgroundColor = .black
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(table)
        setupConstraints()
        table.dataSource = self
        table.delegate = self
        navigationItem.title = "Settings"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let editImage = UIImage(systemName: "pencil")

        editButton = UIBarButtonItem(image: editImage, style: .plain, target: self, action: #selector(editButtonTapped))
        
    }
    
    @objc func editButtonTapped() {
            
    }
    
    
    func showEditButton() {
        // Set the edit button as the right bar button item
        navigationItem.rightBarButtonItem = editButton
    }
    
    func hideEditButton() {
        // Remove the right bar button item
        navigationItem.rightBarButtonItem = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Show the edit button when the text field is tapped
        showEditButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Hide the edit button when editing ends
        hideEditButton()
    }
    
    func setupConstraints() {
        table.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return focusBreakArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell()}
        cell.focusTime.text = focusBreakArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    
}
