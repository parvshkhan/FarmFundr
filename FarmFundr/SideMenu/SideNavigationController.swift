//
//  MenuViewController.swift
//  FarmFundr
//
//  Created by Shaik Baji on 10/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class SideNavigationController: ENSideMenuNavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let menu = storyboard.instantiateViewController(withIdentifier:"MenuViewController") as! MenuViewController
        sideMenu = ENSideMenu(sourceView:self.view, menuViewController: menu, menuPosition:.left)
        sideMenu?.menuWidth = self.view.frame.width;
        view.bringSubview(toFront:navigationBar)
    }
    
    
}
