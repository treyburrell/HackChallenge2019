//
//  TabViewController.swift
//  Cornell Grant APP
//
//  Created by LIbrary User on 4/24/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUP()
    }
    
        func setUP() {
        let Home1 = HomeViewController()
            Home1.tabBarItem = UITabBarItem(title: "home", image: #imageLiteral(resourceName: "home"), tag: 3
            )
        let search1 = ViewController()
            search1.tabBarItem = UITabBarItem(title: "search", image: #imageLiteral(resourceName: "search23"), tag: 2)
        
        let settings1 = SettingsViewController()
        settings1.tabBarItem = UITabBarItem(title: "settings", image: #imageLiteral(resourceName: "settings-work-tool") , tag: 1)
        
        let list = [ Home1, search1, settings1 ]
        viewControllers = list
        

        // Do any additional setup after loading the view.
    }
}
