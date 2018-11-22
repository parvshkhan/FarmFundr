//
//  ThirdSplashViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 05/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class ThirdSplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func action(_ sender : UIButton){
        
        if defaultLeoDefaultUser != nil{
         //   let mainStoryboardIpad : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let initialViewControlleripad : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SideNavigationController") as!  SideNavigationController
//            mainStoryboardIpad.instantiateViewController(withIdentifier: "SideNavigationController") as! SideNavigationController
//          self.present(initialViewControlleripad, animated: true, completion: nil)
           //self.view.window = self.view.fra
            self.view.window?.rootViewController = initialViewControlleripad
           self.view.window?.makeKeyAndVisible()
        }else{
          //  let rootViewController = self.window!.rootViewController as! UINavigationController
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            self.navigationController!.pushViewController(profileViewController, animated: true)
            /*  let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
             self.window = UIWindow(frame: UIScreen.main.bounds)
             self.window?.rootViewController = initialViewControlleripad
             self.window?.makeKeyAndVisible()*/
        }
        
    }
    
    
}
