//
//  KnowledBaseViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 16/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class KnowledBaseViewController: UIViewController {
    //MARK: - Outlets
  
    // MARK:- Class Variables
    
     var nextClassId = "KnowledegeBaseContainsViewController"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func actionIntroBtn(_ sender : UIButton){
        // self.view.makeToast("Work in Progress!")
         let vc =  self.storyboard?.instantiateViewController(withIdentifier: "IntroductionViewController") as! IntroductionViewController
         vc.pageId = 1
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func actionHIWBtn(_ sender : UIButton){
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "IntroductionViewController") as! IntroductionViewController
        vc.pageId = 2
        self.navigationController?.pushViewController(vc, animated: true)
      
    }
    
    @IBAction func actionFarmTypesBtn(_ sender : UIButton){
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "IntroductionViewController") as! IntroductionViewController
        vc.pageId = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionYourAccountBtn(_ sender : UIButton){
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        // vc.pageId = 2
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func actionRegPolicyBtn(_ sender : UIButton){
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "IntroductionViewController") as! IntroductionViewController
        vc.pageId = 5
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionFAQBtn(_ sender : UIButton){
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "IntroductionViewController") as! IntroductionViewController
        vc.pageId = 6
        self.navigationController?.pushViewController(vc, animated: true)
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
  
    //MARK:- getContents Api Integeration
    
    func postApigetContents(){
        let someRqst : [ String : Any ] = ["id" : (defaultLeoDefaultUser?.id!)!]
        WebServices.post(url: Api.getContents.url, jsonObject: someRqst, completionHandler: { (response, _) in
            
        }) { (error, _) in
            
        }
    }
    

}
