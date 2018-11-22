//
//  ResetPasswordViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 02/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtPswrd: HoshiTextField!
    //MARK:- Class Variables
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = defaultLeoDefaultUser!.email!
        // Do any additional setup after loading the view.
    }
   
    @IBAction func actionCloseBtn(_ sender: UIButton) {
        
      self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionNextBtn(_ sender: UIButton) {
        postResetPswrd()
    }
    
    //MARK:- Reset Pswrd Api integeration
    
    func postResetPswrd(){
        let resetPswrdRqst = ["email" : txtEmail.text,"password" : txtPswrd.text!] as [String : Any]
        HUD.show(.progress)
        WebServices.post(url: Api.resetPassword.url, jsonObject: resetPswrdRqst, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
               self.navigationController?.pushViewController(vc, animated: true)
            }
            print("RESPONSE===", response)
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
            print("ERROR")
        }
    }
    
    
}
