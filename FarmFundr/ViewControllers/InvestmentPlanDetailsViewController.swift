//
//  InvestmentPlanDetailsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 22/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class InvestmentPlanDetailsViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    //MARK:- Classs variable
    var id : Int?
    var apiInvestmentDetails : ApiInvestmentPlanDetailsIncomming?
    override func viewDidLoad() {
        super.viewDidLoad()
        postInvestPlanDetails(id : id!)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Api Integeration
    
    func postInvestPlanDetails(id : Int){
        let someRqst : [String : Any] = ["id" : id]
        HUD.show(.progress)
        WebServices.post(url: Api.investmentPlansByParticularId.url, jsonObject: someRqst, completionHandler: { (response, _) in
             HUD.hide()
            self.view.makeToast(getMessage(response: response))
            print("WISHLIST===",response)
            self.apiInvestmentDetails = ApiInvestmentPlanDetailsIncomming(response: response as! NSDictionary)
            self.lblTitle.text = self.apiInvestmentDetails?.planDetail?.title
            self.lblDescription.text = self.apiInvestmentDetails?.planDetail?.description?.htmlToString
        }) { (error, _) in
             //self.view.makeToast(error.localizationDescription)
             HUD.hide()
        }
    }
   
    //MARK:- Close Btn Action
    
    @IBAction func actionCloseBtn(_ sender : UIButton){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- OpenSide Menu
    
    @IBAction func actionMenuBtn(_ sender : UIButton){
       toggleSideMenuView()
    }
    
    @IBAction func actionInvestNowBtn(_ sender : UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SideNavigationController") as! SideNavigationController
       self.present(vc, animated: false, completion: nil)
    }
    
    
}
