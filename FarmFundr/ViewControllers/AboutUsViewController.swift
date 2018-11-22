//
//  AboutUsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 26/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var imgView : UIImageView!
    //MARK:- class Variables
    var apiGetAboutUsIncomming : ApiAboutUsDataIncomming?

    override func viewDidLoad() {
        super.viewDidLoad()
        getAbout()
        // Do any additional setup after loading the view.
    }
  
    //MARK:- GetAbout Api Integeration
    
    func getAbout(){
        HUD.show(.progress)
        WebServices.get(url: Api.getAboutUs.url, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            self.apiGetAboutUsIncomming = ApiAboutUsDataIncomming(response: response as! NSDictionary)
          print("GETDATA==", self.apiGetAboutUsIncomming)
            DispatchQueue.main.async {
               self.lblDescription.text = self.apiGetAboutUsIncomming?.aboutUs?.description?.htmlToString
                self.imgView.load(url: (self.apiGetAboutUsIncomming?.aboutUs?.imgURL)!)
            }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
          // ERROR IN
        }
    }
    
    @IBAction func actionOpenSideMenu(_ sender : UIButton){
        toggleSideMenuView()
    }
    
    @IBAction func actionCloseBtn(_ sender : UIButton){
        let initialViewControlleripad : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SideNavigationController") as! SideNavigationController
        //      self.view.window = self.view.bounds
        self.view.window?.rootViewController = initialViewControlleripad
        self.view.window?.makeKeyAndVisible()
    }
    
    
}
