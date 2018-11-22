//
//  ContactUsVC.swift
//  FarmFundr
//
//  Created by Shaik Baji on 12/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

let borderColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)

class ContactUsVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var confirmEmailTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        textView.layer.borderColor = borderColor.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        
        submitButton.setButtonUI()
        
        //TextField Border UI Color Design
//        firstNameTF.setDesignUI()
//        lastNameTF.setDesignUI()
//        emailTF.setDesignUI()
//        confirmEmailTF.setDesignUI()
}

    @IBAction func submitBtnTapped(_ sender: UIButton)
    {
        
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

extension UITextField
{
  func setDesignUI()
    {
       self.layer.borderColor = borderColor.cgColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 5.0;
        self.borderStyle = .none
    }
        func borderNone()
        {
            self.borderStyle = .none
            self.layer.masksToBounds = false
            self.layer.shadowColor = borderColor.cgColor;
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 0.0
        }
    
}
extension UIButton
{
    func setButtonUI()
    {
        self.layer.cornerRadius =  self.bounds.size.height / 2
    }
}
