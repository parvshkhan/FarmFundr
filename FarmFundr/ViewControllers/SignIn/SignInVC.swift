
//
//  SignInVC.swift
//  FarmFundr
//
//  Created by Shaik Baji on 14/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class SignInVC: UIViewController
{

    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      signInBtn.layer.cornerRadius = signInBtn.frame.size.height/2
      signInBtn.layer.masksToBounds = true
      signUpBtn.layer.cornerRadius = signInBtn.frame.size.height/2
      signUpBtn.layer.masksToBounds = true
   }
    
@IBAction func signInTapped(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier:"LogInVC") as! LogInVC
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier:"RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated:true)
    }
}


