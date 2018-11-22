//
//  MatchOtpViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 02/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class MatchOtpViewController: UIViewController {

    //MARK:-  Outlets

    @IBOutlet weak var txtOtp: HoshiTextField!
    
    //MARK:- Class Variable
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actionNextBtn(_ sender: UIButton) {
         postMatchOtp()
        
    }
  
    @IBAction func actionCloseBtn(_ sender: UIButton) {
       self.navigationController?.popViewController(animated: true)
    }
  
    // MARK:- Matchotp Api  Integeration
    
    func postMatchOtp(){
        let matchRqst = ["userId": defaultLeoDefaultUser!.id! ,"otp": txtOtp.text!] as [String : Any]
        HUD.show(.progress)
        WebServices.post(url: Api.matchOtp.url, jsonObject: matchRqst, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            print("RESPONSE==", response)
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
            print("ERROR===", error)
        }
    }
    
    
}
