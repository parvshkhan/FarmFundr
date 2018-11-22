//
//  RegisterVC.swift
//  FarmFundr
//
//  Created by Shaik Baji on 14/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController
{
    
    // MARK:- Outlets
    @IBOutlet weak var emailTF: HoshiTextField!
    @IBOutlet weak var passwordTF: HoshiTextField!
    @IBOutlet weak var confirmPasswordTF: HoshiTextField!
    @IBOutlet weak var usernameTF: HoshiTextField!
    @IBOutlet weak var createAccount: UIButton!
    // MARK:- Class Variables
    var apiUserRegisterIncomming : ApiUserSignUpInComming?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        emailTF.borderNone()
        passwordTF.borderNone()
        confirmPasswordTF.borderNone()
        usernameTF.borderNone()
        createAccount.setButtonUI()
        let imageView = UIImageView()
        imageView.frame = CGRect(x:0, y:0, width:30, height:30)
        let image = UIImage(named:"user-2.png")
        imageView.image = image;
        self.emailTF.leftView = imageView
        self.emailTF.leftViewMode = .always
    }
    

    @IBAction func backBtnTapped(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSignUpBtn(_ sender : UIButton){
        checkValidations()
        
    }
    
    // MARK:- Check Validations
    
    func checkValidations(){
        if usernameTF.text == ""{
            self.view.makeToast("Please Enter UserName!")
            return
        }
        if emailTF.text == ""{
            self.view.makeToast("Please Enter Email!")
            return
        } else if emailTF.text != ""{
            if !isValidEmail(emailTF.text!){
                self.view.makeToast("Please Enetr a Valid EmailId!")
                return
            }
        }
        if passwordTF.text == ""{
            self.view.makeToast("Please Enter your Password!")
            return
        }else if passwordTF.text != ""{
            if !isPasswordValid(pswrd: passwordTF.text!){
                self.view.makeToast("Password should have minimum length of eight character,One Alphabate ,One Special Character!")
                return
            }
        }
        if confirmPasswordTF.text == ""{
            confirmPasswordTF.becomeFirstResponder()
            self.view.makeToast("Please Confirm Your Password!")
            return
        }else if confirmPasswordTF.text != ""{
            if passwordTF.text != confirmPasswordTF.text{
               // confirmPasswordTF.becomeFirstResponder()
                self.view.makeToast("Password does not Matche!")
                return
            }
    }
    postSignUp()
    
    }
    
    
    
    // MARK :- Integerate Signup Api Here
    
    func postSignUp(){
        let request = ["first_name": usernameTF.text!,"email": emailTF.text! ,"password" : passwordTF.text! ] as! [String : Any]
        HUD.show(.progress)
        WebServices.post(url: Api.signUp.url, jsonObject: request, completionHandler: { (response, _) in
            HUD.hide()
            print("Response===" , response)
            self.view.makeToast(getMessage(response: response))
          //  print("Message", getMessage(response: response))
            if isApiSussess(response: response){
              self.apiUserRegisterIncomming = ApiUserSignUpInComming(response: response as! [String : Any])
                print(self.apiUserRegisterIncomming)
                if self.apiUserRegisterIncomming != nil{
                    defaultLeoDefaultUser = DefaultLeoUser(id: self.apiUserRegisterIncomming?.userData?.id! ?? 0, email: self.apiUserRegisterIncomming?.userData?.email! ?? "", firstName: self.apiUserRegisterIncomming?.userData?.firstName! ?? "")
                }
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SideNavigationController") as! SideNavigationController
            //    self.view.window = UIWindow(frame: self.view.frame)
                self.view.window?.rootViewController = vc
                self.view.window?.makeKeyAndVisible()
            }else if isApiError(response: response){
                print("Message", getMessage(response: response))
            }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
            print("Error", error)
        }
   
    }
    
    // MARK:- Email Validation
    
    func isValidEmail(_ testStr:String) -> Bool
    {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: testStr)
        
    }
   
    //MARK:- Password Validation
    
    func isPasswordValidComplexLeoSignUpUIModel(pswrd : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$")
        return passwordTest.evaluate(with: pswrd)
    }
    
    
    func isPasswordValid(pswrd : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: pswrd)
    }
    
}
