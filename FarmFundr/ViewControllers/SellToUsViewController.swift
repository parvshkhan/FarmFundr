//
//  SellToUsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 26/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class SellToUsViewController: UIViewController {
    // MARK:- Outlets
    @IBOutlet weak var tblSellToUsList : UITableView!
    @IBOutlet weak var lblTitleDesc : UILabel!
    // MARK:- Class variables
    var apiGetSellToUsData : ApiSellToUsIncomming?
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleDesc.text = "Choose Farm investment with the highest re- \n turns on investment. \n Net Total Returns per annum 10%+."
        tblSellToUsList.estimatedRowHeight = 70
        tblSellToUsList.rowHeight = UITableViewAutomaticDimension
        getSellToUsData()
        // Do any additional setup after loading the view.
    }
    //MARK:- sellToUsData
    func getSellToUsData(){
        HUD.show(.progress)
        WebServices.get(url: Api.getselltoUs.url, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            self.apiGetSellToUsData = ApiSellToUsIncomming(response: response)
            DispatchQueue.main.async {
                self.tblSellToUsList.reloadData()
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

extension SellToUsViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiGetSellToUsData?.sellDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SellToUsListTableViewCell.cellId) as! SellToUsListTableViewCell
        let someSellData = apiGetSellToUsData?.sellDetails[indexPath.row]
       cell.Configure(sellDetail: someSellData!)
        return cell
    }
}

class SellToUsListTableViewCell : UITableViewCell{
    //MARK:- Outlets
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDesc : UILabel!
    // MARK:- Class Variables
    static let cellId = "SellToUsListTableViewCell"
    var sellDetail : ApiSellToUsIncomming.SellDetail?
    
    func Configure(sellDetail : ApiSellToUsIncomming.SellDetail)  {
        self.sellDetail = sellDetail
        lblTitle.text = sellDetail.title
        lblDesc.text = sellDetail.description!.htmlToString
    }
}
