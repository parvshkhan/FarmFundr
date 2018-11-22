//
//  ForgotPasswordViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 01/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmailId: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionCloseBtn(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionNextBtn(_ sender: UIButton) {
       postForgotPassWord()
    }
    
    // MARK:- forgot Password Api Integeration
    func postForgotPassWord(){
        let rqst = ["email" : txtEmailId.text!]
        HUD.show(.progress)
        WebServices.post(url: Api.forgetPassword.url, jsonObject: rqst, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
             print("RESPONSE==" , response)
        }) { (error , _) in
           HUD.hide()
           self.view.makeToast("Error in Getting Response")
        }
    }
    
    
    
}
