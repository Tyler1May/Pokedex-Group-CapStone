//
//  TabBarViewController.swift
//  Pokedex
//
//  Created by Tyler May on 4/16/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchViewController: UIViewController = UIStoryboard(name: "SearchView", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as UIViewController
        
        let myTeamViewController: UIViewController = UIStoryboard(name: "MyTeamView", bundle: nil).instantiateViewController(withIdentifier: "MyTeamViewController") as UIViewController
        
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        myTeamViewController.tabBarItem = UITabBarItem(title: "My Team", image: UIImage(named: "pokeball"), tag: 1)
        
        self.viewControllers = [searchViewController, myTeamViewController]
        
    }
    
    
}
