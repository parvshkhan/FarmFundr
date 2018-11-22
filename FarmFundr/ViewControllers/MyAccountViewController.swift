//
//  MyAccountViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 02/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit
import SwiftEventBus

class MyAccountViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var txtLastName : UITextField!
    // MARK:- Class Variables
    var apiGetUserInfoIncomming : ApiGetUserInfoIncomming?
    var apiUpdateProfileIncomming : ApiUpdateProfileIncomming?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postShowProfile()
        txtUserName.text = defaultLeoDefaultUser?.firstName!
        txtEmailId.text = defaultLeoDefaultUser?.email! 
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func actionUpdatePicBtn(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            print("the picked up image is ",image)
            self.profileImageView.image = image  ////**/ here imageView is the view where u want to show the image that is picked
        }
    }

    @IBAction func actionMenuBtn(_ sender: UIButton) {
        
        toggleSideMenuView()
        
    }
    
    @IBAction func actionEditProfileBtn(_ sender: UIButton) {
        txtUserName.isEnabled = true
        txtLastName.isEnabled = true
        txtAddress.isEnabled = true
        txtPhoneNumber.isEnabled = true
    }
   
    @IBAction func actionCloseBtn(_ sender: UIButton){
        let initialViewControlleripad : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SideNavigationController") as! SideNavigationController
  //      self.view.window = self.view.bounds
        self.view.window?.rootViewController = initialViewControlleripad
        self.view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func actionUpdateBtn(_ sender: UIButton) {
       postUpdateProfile()
        txtUserName.isEnabled = false
        txtLastName.isEnabled = false
        txtAddress.isEnabled = false
        txtPhoneNumber.isEnabled = false
    }
    
    // MARK:- ShowProfile APi
    func postShowProfile(){
        let id = defaultLeoDefaultUser!.id!
        let rqst = ["id": id]
        WebServices.post(url: Api.getProfile.url, jsonObject: rqst, completionHandler: { (response, _) in
            self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response){
                self.apiGetUserInfoIncomming = ApiGetUserInfoIncomming(response: response as! [String : Any])
                    //ApiShowProfileIncomming(dictionary: response as! [String : Any] as NSDictionary)
                self.txtUserName.text = self.apiGetUserInfoIncomming?.userDetails?.firstName
                self.txtEmailId.text = self.apiGetUserInfoIncomming?.userDetails?.email
                self.profileImageView.load(url: (self.apiGetUserInfoIncomming?.userDetails?.imgUrl)!)
                if self.apiGetUserInfoIncomming?.userDetails?.mobile != nil{
                    self.txtPhoneNumber.text = self.apiGetUserInfoIncomming?.userDetails?.mobile ?? "NG"
                }
                
//                self.txtPhoneNumber.text = String(self.apiGetUserInfoIncomming!.userDetails!.mobile!) ?? "NG"
                self.txtAddress.text = "NG"
            }else{
               
            }
            print("RESPONSE==", response)
        }) { (error, _) in
            print("Error Here")
        }
    }

    // MARK:- Update Profile Api Implemention
    
    func postUpdateProfile(){
        let updateRqst = ["id": defaultLeoDefaultUser!.id! , "firstName" : txtUserName.text! , "mobile" : txtPhoneNumber.text! , "lastName" : txtLastName.text!] as [String : Any]
        HUD.show(.progress)
        WebServices.uploadSingleImage(url: Api.updateProfile.url, jsonObject: updateRqst, image: profileImageView.image, completionHandler: { (response, _) in
            HUD.hide()
            self.apiUpdateProfileIncomming = ApiUpdateProfileIncomming(dictionary: response as! NSDictionary)
           SwiftEventBus.post("updateProfile", sender: self.apiUpdateProfileIncomming as! AnyObject)
            
        }) { (error, _) in
             HUD.hide()
            print("ERROR ")
        }
    }
}
