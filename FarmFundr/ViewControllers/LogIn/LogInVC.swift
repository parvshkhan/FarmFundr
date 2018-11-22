//
//  LogInVC.swift
//  FarmFundr
//
//  Created by Shaik Baji on 14/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit


class LogInVC: UIViewController
{
    // MARK :- Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTF: HoshiTextField!
    @IBOutlet weak var passwordTF: HoshiTextField!
    // MARK :- Class Variables
    var apiLoginDetailsIncomming : ApiLoginDataIncomming?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        emailTF.borderNone()
//        passwordTF.borderNone()
        loginBtn.setButtonUI()
       
    }

    @IBAction func forgotPasswordTapped(_ sender: UIButton)
    {
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton)
    {
        postSignIn()
      
       
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated:true)
    }
    // MARK : - Integerate Login Api Here
    func postSignIn(){
    let loginRequest = ["email": emailTF.text! , "password": passwordTF.text!]
       HUD.show(.progress)
       WebServices.post(url: Api.signIn.url, jsonObject: loginRequest, completionHandler: { (response, _) in
        HUD.hide()
        self.view.makeToast(getMessage(response: response))
        if isApiSussess(response: response){
            self.apiLoginDetailsIncomming = ApiLoginDataIncomming(response: response as! [String : Any])
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"SideNavigationController") as! SideNavigationController
            self.present(vc, animated: true, completion: nil)
            if self.apiLoginDetailsIncomming != nil{
                defaultLeoDefaultUser = DefaultLeoUser(id: self.apiLoginDetailsIncomming?.userLogin?.id! ?? 0, email: self.apiLoginDetailsIncomming?.userLogin?.email! ?? "", firstName: self.apiLoginDetailsIncomming?.userLogin?.firstName! ?? "")
            }
//              self.view.window?.rootViewController = vc
//              self.view.window?.makeKeyAndVisible()
              print("Response==",  self.apiLoginDetailsIncomming , getMessage(response: response))
        }else if isApiError(response: response){
            print("Response==", self.apiLoginDetailsIncomming , getMessage(response: response))
        }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
            print("Error")
        }
        
    }
    
    
}
