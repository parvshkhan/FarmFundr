//
//  AboutUsVC.swift
//  FarmFundr
//
//  Created by Shaik Baji on 12/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func menuBtnTapped(_ sender: UIButton)
    {
        showSideMenuView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        hideSideMenuView()
    }
}
