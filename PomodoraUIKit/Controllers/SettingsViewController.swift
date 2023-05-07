//
//  SettingsViewController.swift
//  PomodoraUIKit
//
//  Created by Али  on 06.05.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 21))
        label.text = "Settings"
        
        self.view.addSubview(label)
//        label.frame = view.bounds
        // Do any additional setup after loading the view.
    }
    

    

}
