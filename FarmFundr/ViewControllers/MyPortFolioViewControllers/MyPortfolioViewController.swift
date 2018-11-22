//
//  MyPortfolioViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 29/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class MyPortfolioViewController: UIViewController {

    @IBOutlet var btnTabs: [TabButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
  
    
    @IBAction func actionBtnTabs(_ sender: TabButton) {
      
        for btn in btnTabs{
            if sender.tag == btn.tag{
            btn.isSelected = true
            }else{
          btn.isSelected = false
            }
        }
        
    }
    
    
}
