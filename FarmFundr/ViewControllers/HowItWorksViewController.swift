//
//  HowItWorksViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 29/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class HowItWorksViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblHIWList : UITableView!
    //MARK:- Class Variables
    var apiHowItWorksIncomming : ApiGetHowItWorksIncomming?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblHIWList.estimatedRowHeight = 80
        tblHIWList.rowHeight = UITableViewAutomaticDimension
        getHowItWork()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Actions On Button
    
    @IBAction func actionOpenSideMenu(_ sender : UIButton){
        toggleSideMenuView()
    }
    
    @IBAction func actionCloseBtn(_ sender : UIButton){
        let initialViewControlleripad : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SideNavigationController") as! SideNavigationController
        //      self.view.window = self.view.bounds
        self.view.window?.rootViewController = initialViewControlleripad
        self.view.window?.makeKeyAndVisible()
    }
    
    //MARK:- GetHowItWorks Api integeration
    
    func getHowItWork(){
        HUD.show(.progress)
        WebServices.get(url: Api.getHowItWorks.url, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            self.apiHowItWorksIncomming = ApiGetHowItWorksIncomming(response: response)
            DispatchQueue.main.async {
                self.tblHIWList.reloadData()
            }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
            print("Error")
        }
    }
    
}

//MARK:- UITableView Datasource And Delegates

extension HowItWorksViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiHowItWorksIncomming?.workDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HowItWorksListTableViewCell") as! HowItWorksListTableViewCell
        let someWork = apiHowItWorksIncomming?.workDetails[indexPath.row]
        cell.configure(work: someWork!)
        return cell
    }
    
}

// MARK:- TableViewCell Class

class HowItWorksListTableViewCell : UITableViewCell{
     //MARK:- Outlets
    @IBOutlet weak var imgWork : UIImageView!
    @IBOutlet weak var lblDesc : UILabel!
     // MARK:- Class Variables
    var work : ApiGetHowItWorksIncomming.WorkDetail?
    // MARK:- Action
    
    // MARK:- Methods
    func configure(work : ApiGetHowItWorksIncomming.WorkDetail)  {
        self.work = work
        lblDesc.text = work.description?.htmlToString
        imgWork.load(url: work.imgUrl)
    }
    
    
}
