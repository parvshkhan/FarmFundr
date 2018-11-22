//
//  PremiumServicesViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 26/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class PremiumServicesViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var tblPremiumList : UITableView!
    @IBOutlet weak var lblTitleDesc : UILabel!
    // MARK:- Class variables
    var apiGetPremiumList : ApiGetPremiumServiceIncomming?
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleDesc.text = "Speak to our investment team and \n we'll create a farm portfolio that's \n tailored to your specific investment \n goal"
        tblPremiumList.estimatedRowHeight = 70
        tblPremiumList.rowHeight = UITableViewAutomaticDimension
        getPremiumService()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- getAllPremiumService Api Integeration
    
    func getPremiumService(){
        HUD.show(.progress)
        WebServices.get(url: Api.getPremiumServices.url, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            self.apiGetPremiumList = ApiGetPremiumServiceIncomming(response: response)
            DispatchQueue.main.async {
                self.tblPremiumList.reloadData()
            }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
            print("ERROR")
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

extension PremiumServicesViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiGetPremiumList?.premiumDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PremiumListTableViewCell.cellId) as! PremiumListTableViewCell
        let somePremium = apiGetPremiumList?.premiumDetails[indexPath.row]
        cell.Configure(premiumDetail: somePremium!)
        return cell
    }
}

class PremiumListTableViewCell : UITableViewCell{
    //MARK:- Outlets
    @IBOutlet weak var lblQues : UILabel!
    @IBOutlet weak var lblAns : UILabel!
    // MARK:- Class Variables
    static let cellId = "PremiumListTableViewCell"
    var premiumDetail : ApiGetPremiumServiceIncomming.PremiumDetail?
    
    func Configure(premiumDetail : ApiGetPremiumServiceIncomming.PremiumDetail)  {
        self.premiumDetail = premiumDetail
        lblQues.text = premiumDetail.question
        lblAns.text = premiumDetail.answer?.htmlToString
    }
}
