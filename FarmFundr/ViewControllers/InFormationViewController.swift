//
//  InFormationViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 30/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class InFormationViewController: UIViewController {
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       lblAddress.text! = "Usa H-20 florida USA"
       lblEmailAddress.text! = "warritv1.com@gmail.com"
        lblPhoneNumber.text! = "+0101124578963"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionDismisBtn(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
