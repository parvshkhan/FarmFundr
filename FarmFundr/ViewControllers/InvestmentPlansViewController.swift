//
//  InvestmentPlansViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 12/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//
struct InvestModal {
    var name : String?
    var descr : String?
    
}



import UIKit
class InvestmentPlansViewController: UIViewController {
    //Mark:- Outlets
    @IBOutlet weak var tblInvestPlan : UITableView!
    
   //MARK:- Class Variables
    var invstArr : [InvestModal] = []
    var apiInvestmentPlans  : ApiGetAllInvestmentPlanIncomming?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblInvestPlan.estimatedRowHeight = 70.0
        tblInvestPlan.rowHeight = UITableViewAutomaticDimension
        getInvestment()
        invstArr = [InvestModal(name: "afusgdu", descr: "hksuikuwehgi.ygoerguerogergeikrgerg"),InvestModal(name: "afusgdu", descr: "hksuikuwehgi.ygoerguerogergeikrgergdewkugejrghhugjkrgkrjkghjkrhjkrjkgejkrgjkehjkrgehjkrghrhjkgjkrgfyughergejrkghkerkgejkrgerhjkgejkrgjerjgherjgejrgj"),InvestModal(name: "afusgdu", descr: "hksuikuwehgi.ygoerguer"),InvestModal(name: "afusgdu", descr: "hksuikuwehgi.ygoerguerogergeikrgergftwufwfghsgfjdhsfgjhdsgfdhsfgjdsgfjdhgfdhsgfhjfghdfgdhsfgdhsfgsdhgfjhsgfhsfghsfgdhsfgdshfgdsfgsdgfdfghdsfghsdgfhdgfdhsfghdfgjsdgfhsgfjshgf")]
        // Do any additional setup after loading the view.
    }
    
    func  getInvestment(){
        WebServices.get(url: Api.getInvestmentPlans.url, completionHandler: { (response, _) in
           self.apiInvestmentPlans = ApiGetAllInvestmentPlanIncomming(response: response)
            DispatchQueue.main.async {
                self.tblInvestPlan.reloadData()
            }
        }) { (error, _) in
            
        }
    
    }
  
    @IBAction func actionCloseBtn(_ sender : UIButton){
        let initialViewControlleripad : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SideNavigationController") as! SideNavigationController
        //      self.view.window = self.view.bounds
        self.view.window?.rootViewController = initialViewControlleripad
        self.view.window?.makeKeyAndVisible()
       
        
    }
    
    @IBAction func actionMenuBtn(_ sender : UIButton){
      toggleSideMenuView()
    }
    
}

extension InvestmentPlansViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiInvestmentPlans?.investmentPlan.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvestmentPalnTableViewCell.identifier) as! InvestmentPalnTableViewCell
        let some = apiInvestmentPlans?.investmentPlan[indexPath.row]
        cell.configure(investmentPlan: some!)
        cell.closureDidTapOnInvestmentPlan = { plan in
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "InvestmentPlanDetailsViewController") as! InvestmentPlanDetailsViewController
         vc.id = plan.id
         self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
}

class InvestmentPalnTableViewCell : UITableViewCell{
    //MARK:- Outlets
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblDesc : UILabel!
    //MARK:- Class Variables
    static let identifier = "InvestmentPalnTableViewCell"
    var investmentPlan : ApiGetAllInvestmentPlanIncomming.InvestmentPlan?
    var closureDidTapOnInvestmentPlan : ((ApiGetAllInvestmentPlanIncomming.InvestmentPlan) -> Void)?
    
    func configure(investmentPlan : ApiGetAllInvestmentPlanIncomming.InvestmentPlan)  {
        self.investmentPlan = investmentPlan
        lblDesc.text = investmentPlan.description?.htmlToString
        lblName.text = investmentPlan.title
    }
    
    @IBAction func actionLearnMoreBtn(_ sender : UIButton){
        closureDidTapOnInvestmentPlan?(investmentPlan!)
    }
    
}
