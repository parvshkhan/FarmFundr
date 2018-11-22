//
//  MenuViewController.swift
//  FarmFundr
//
//  Created by Shaik Baji on 10/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit
import SwiftEventBus

struct menuStruct
{
    var names:String!
    var images:UIImage!
}

class ExpandedCollapsedCell :UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    
}

class MenuViewController: UIViewController
{
    // MARK:- Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Class variables
    var menuArray  = [menuStruct]()
    var menuArray2 = [menuStruct]()
    var destination:UIViewController?
    var apiGetUserInfoIncomming : ApiGetUserInfoIncomming?
    let kHeaderSectionTag: Int = 6900
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var sectionItems: [Any] = []
    var sectionNames: [Any] = []
    var apiUpdatedProfile : ApiUpdateProfileIncomming?
    // MARK:- Class Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.layer.masksToBounds = true
        sectionItems = [[],[],[],[],[],["About Us","How it works","Sell to us","Knowledge Base","Blogs","Events"]]
    /*    menuArray = [menuStruct(names:"My Account",images:#imageLiteral(resourceName: "MyAccount")),menuStruct(names:"Profile",images:#imageLiteral(resourceName: "MyAccount")),menuStruct(names:"Investment Plan",images:#imageLiteral(resourceName: "InvestmentPlan")),menuStruct(names:"Property Plan",images:#imageLiteral(resourceName: "InvestmentPlan")),menuStruct(names:"Wishlist",images:#imageLiteral(resourceName: "Wishlist"))]
        
        menuArray2 = [menuStruct(names:"Settings",images:#imageLiteral(resourceName: "Settings")),menuStruct(names:"Logout",images:#imageLiteral(resourceName: "Logout"))] */
        if defaultLeoDefaultUser?.id != nil || defaultLeoDefaultUser?.firstName != nil {
            nameLabel.text = defaultLeoDefaultUser!.firstName!
            emailLabel.text = defaultLeoDefaultUser!.email!
              print("EmailPassword==", defaultLeoDefaultUser!.firstName! , defaultLeoDefaultUser!.email! , defaultLeoDefaultUser )
        }
        
       //  postShowProfile()
      
          self.tableView!.tableFooterView = UIView()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //postShowProfile()
        SwiftEventBus.onMainThread((target as? AnyObject)!, name: "updateProfile") { data in
            self.apiUpdatedProfile = data?.object as! ApiUpdateProfileIncomming
            self.profileImage.load(url: (self.apiUpdatedProfile?.updateProfile?.imgUrl)!)
            self.nameLabel.text = self.apiUpdatedProfile?.updateProfile?.first_name
            self.emailLabel.text = self.apiUpdatedProfile?.updateProfile?.email
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
       
    }
  
    @IBAction func backgroundBtn(_ sender : UIButton){
       toggleSideMenuView()
    }
    
    @IBAction func backSideMenuBtn(_ sender : UIButton){
        toggleSideMenuView()
    }
    
    // MARK:- AddObserber to profileUpdate
    
   
    //MARK:- ShowInfo Api Integeration
    
    func postShowProfile(){
        let id = defaultLeoDefaultUser!.id!
        let rqst = ["id": id]
        HUD.show(.progress)
        WebServices.post(url: Api.getProfile.url, jsonObject: rqst, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response){
                self.apiGetUserInfoIncomming = ApiGetUserInfoIncomming(response: response as! [String : Any])
                self.nameLabel.text = self.apiGetUserInfoIncomming?.userDetails?.firstName
                self.emailLabel.text = self.apiGetUserInfoIncomming?.userDetails?.email
                self.profileImage.load(url: (self.apiGetUserInfoIncomming?.userDetails?.imgUrl)!)
            }else{
                
            }
            print("RESPONSE==", response)
        }) { (error, _) in
             HUD.hide()
            self.view.makeToast(error.localizedDescription)
            print("Error Here")
        }
    }
    
    // MARK:- LogOut Api Integeration
    
    func postLogOut(){
    let logOutRqst : [String : Any] = ["id" : (defaultLeoDefaultUser?.id!)!]
        HUD.show(.progress)
        WebServices.post(url: Api.logOut.url, jsonObject: logOutRqst, completionHandler: { (response, _) in
          HUD.hide()
          self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response ){
               defaultLeoDefaultUser?.id = nil
               defaultLeoDefaultUser?.firstName = nil
               defaultLeoDefaultUser?.email = nil
                
              self.navigationController?.popViewController(animated: true)
            }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
        }
    }
}

// MARK:- UITableViewDelegate and DataSource

extension MenuViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 9
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.expandedSectionHeaderNumber == section)
        {
            let arrayOfItems = self.sectionItems[section] as! NSArray
            return arrayOfItems.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (self.sectionNames.count != 0)
        {
            return self.sectionNames[section] as? String
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier:"ExpandedCollapsedCell", for:indexPath) as! ExpandedCollapsedCell
        let section = self.sectionItems[indexPath.section] as! NSArray
        cell.titleLabel.text = section[indexPath.row] as? String
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 45.0
    }
    
    // MARK :- Set HeaderTitle
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let header:UIView =  UIView()
        header.frame = CGRect(x: 10, y: 5, width:self.tableView.frame.size.width, height: 30)
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section)
        {
            viewWithTag.removeFromSuperview()
        }
        if(section==0)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 100, y: 8, width: 18, height: 18));
            theImageView.image = UIImage(named: "next")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            let titleLbl = UILabel(frame: CGRect(x: 70, y: 8, width: header.frame.size.width, height: 30))
            titleLbl.text = "MyAccount"
            titleLbl.textColor = UIColor.white
            header.addSubview(titleLbl)
            let theImageView2 = UIImageView(frame: CGRect(x: 16, y:8, width: 50, height:30));
            theImageView2.image = UIImage(named: "MyAccount")
            theImageView2.contentMode = .scaleAspectFit
            theImageView2.tag = kHeaderSectionTag + section
            header.addSubview(theImageView2)
            let button = UIButton(frame: CGRect(x: 0, y: 0, width:header.frame.size.width, height:header.frame.size.height+33))
            button.addTarget(self, action:#selector(goToMyAccount), for:.touchUpInside)
            header.addSubview(button)
        }
        if(section == 1)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 100, y: 8, width: 18, height: 18));
            theImageView.image = UIImage(named: "next")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            let titleLbl = UILabel(frame: CGRect(x: 70, y: 8, width: header.frame.size.width, height: 30))
            titleLbl.text = "My Portfolio"
            titleLbl.textColor = UIColor.white
            header.addSubview(titleLbl)
            let theImageView2 = UIImageView(frame: CGRect(x: 16, y:8, width: 50, height:30));
            theImageView2.image = UIImage(named: "support")
            theImageView2.contentMode = .scaleAspectFit
            theImageView2.tag = kHeaderSectionTag + section
            header.addSubview(theImageView2)
            let button = UIButton(frame: CGRect(x: 0, y: 0, width:header.frame.size.width, height:header.frame.size.height+33))
            button.addTarget(self, action:#selector(goToMyPortFolio), for:.touchUpInside)
            header.addSubview(button)
        }
        if(section == 2)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 100, y: 8, width: 18, height: 18));
            theImageView.image = UIImage(named: "next")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            let titleLbl = UILabel(frame: CGRect(x: 70, y: 8, width: header.frame.size.width, height: 30))
            titleLbl.text = "Investment Plan"
            titleLbl.textColor = UIColor.white
            header.addSubview(titleLbl)
            let theImageView2 = UIImageView(frame: CGRect(x: 16, y:8, width: 50, height:30));
            theImageView2.image = UIImage(named: "InvestmentPlan")
            theImageView2.contentMode = .scaleAspectFit
            theImageView2.tag = kHeaderSectionTag + section
            header.addSubview(theImageView2)
            let button = UIButton(frame: CGRect(x: 0, y: 0, width:header.frame.size.width, height:header.frame.size.height+33))
            button.addTarget(self, action:#selector(goToMyInvestmentPlans), for:.touchUpInside)
            header.addSubview(button)
            
        }
        else if(section == 3)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 100, y: 8, width: 18, height: 18));
            theImageView.image = UIImage(named: "next")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            let titleLbl = UILabel(frame: CGRect(x: 70, y: 8, width: header.frame.size.width, height: 30))
            titleLbl.text = "Farm"
            titleLbl.textColor = UIColor.white
            header.addSubview(titleLbl)
            let theImageView2 = UIImageView(frame: CGRect(x: 16, y:8, width: 50, height:30));
            theImageView2.image = UIImage(named: "InvestmentPlan")
            theImageView2.contentMode = .scaleAspectFit
            theImageView2.tag = kHeaderSectionTag + section
            header.addSubview(theImageView2)
            let button = UIButton(frame: CGRect(x: 0, y: 0, width:header.frame.size.width, height:header.frame.size.height+33))
            button.addTarget(self, action:#selector(goToMyFarm), for:.touchUpInside)
            header.addSubview(button)
            
        }
        else if(section == 4)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 100, y: 8, width: 18, height: 18));
            theImageView.image = UIImage(named: "next")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            let titleLbl = UILabel(frame: CGRect(x: 70, y: 8, width: header.frame.size.width, height: 30))
            titleLbl.text = "Premium Services"
            titleLbl.textColor = UIColor.white
            header.addSubview(titleLbl)
            let theImageView2 = UIImageView(frame: CGRect(x: 16, y:8, width: 50, height:30));
            theImageView2.image = UIImage(named: "star")
            theImageView2.contentMode = .scaleAspectFit
            theImageView2.tag = kHeaderSectionTag + section
            header.addSubview(theImageView2)
            let button = UIButton(frame: CGRect(x: 0, y: 0, width:header.frame.size.width, height:header.frame.size.height+33))
            button.addTarget(self, action:#selector(goToPremiumServices), for:.touchUpInside)
            header.addSubview(button)
        }
        else if(section == 5)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 100, y: 8, width: 18, height: 18));
            theImageView.image = UIImage(named: "next")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            let titleLbl = UILabel(frame: CGRect(x: 70, y: 8, width: header.frame.size.width, height: 30))
            titleLbl.text = "Resources"
            titleLbl.textColor = UIColor.white
            header.addSubview(titleLbl)
            let theImageView2 = UIImageView(frame: CGRect(x: 16, y:8, width: 50, height:30));
            theImageView2.image = UIImage(named: "MyAccount")
            theImageView2.contentMode = .scaleAspectFit
            theImageView2.tag = kHeaderSectionTag + section
            header.addSubview(theImageView2)
        }
        else if(section == 6)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 100, y: 8, width: 18, height: 18));
            theImageView.image = UIImage(named: "next")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            let theImageView2 = UIImageView(frame: CGRect(x: 16, y:8, width: 50, height:30));
            theImageView2.image = UIImage(named: "Wishlist")
            theImageView2.contentMode = .scaleAspectFit
            theImageView2.tag = kHeaderSectionTag + section
            header.addSubview(theImageView2)
            let button = UIButton(frame: CGRect(x: 0, y: 0, width:header.frame.size.width, height:header.frame.size.height+33))
           button.addTarget(self, action:#selector(goToMyWishList), for:.touchUpInside)
            header.addSubview(button)
            let titleLbl = UILabel(frame: CGRect(x: 70, y: 8, width: header.frame.size.width, height: 30))
            titleLbl.text = "Wishlist"
            titleLbl.textColor = UIColor.white
            header.addSubview(titleLbl)
            let bottomLbl = UILabel(frame: CGRect(x: 8, y: 44, width: header.frame.size.width - 25 , height: 1))
            bottomLbl.text = ""
            bottomLbl.textColor = .white
            bottomLbl.backgroundColor = .white
            header.addSubview(bottomLbl)
            
        }
        else if(section == 7)
        {
            
            let theImageView2 = UIImageView(frame: CGRect(x: 16, y:8, width: 50, height:30));
            theImageView2.image = UIImage(named: "dashboard")
            theImageView2.contentMode = .scaleAspectFit
            theImageView2.tag = kHeaderSectionTag + section
            header.addSubview(theImageView2)
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width:header.frame.size.width, height:header.frame.size.height+33))
            
            button.addTarget(self, action:#selector(goToContactUs), for:.touchUpInside)
            header.addSubview(button)
            
            let titleLbl = UILabel(frame: CGRect(x: 70, y: 8, width: header.frame.size.width, height: 30))
            titleLbl.text = "Contact Us"
            titleLbl.textColor = UIColor.white
            header.addSubview(titleLbl)
        }
        else if(section == 8)
        {
            
            let theImageView2 = UIImageView(frame: CGRect(x: 16, y:8, width: 50, height:30));
            theImageView2.image = UIImage(named: "logout-1")
            theImageView2.contentMode = .scaleAspectFit
            theImageView2.tag = kHeaderSectionTag + section
            header.addSubview(theImageView2)
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width:header.frame.size.width, height:header.frame.size.height+33))
            
     //      button.addTarget(self, action:#selector(logOut), for:.touchUpInside)
            header.addSubview(button)
            let titleLbl = UILabel(frame: CGRect(x: 70, y: 8, width: header.frame.size.width, height: 30))
            titleLbl.text = "Logout"
            titleLbl.textColor = UIColor.white
            header.addSubview(titleLbl)
        }
        else
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 8, width: 18, height:18));
            theImageView.image = UIImage(named: "arrow")
            theImageView.tag = kHeaderSectionTag + section
            //header.addSubview(theImageView)
            
        }
        // MARK:- Add Gesture on Header to Expand or Collapse Cell
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(self.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
        return header
    }
 
    //MARK: - Perform Actions On Header
    @objc func goToMyAccount()
    {
        destination = storyboard?.instantiateViewController(withIdentifier:"MyAccountViewController") as! MyAccountViewController
        sideMenuController()?.setContentViewController(destination!)
    }
    // MARK:- goToMyPortFolio
    @objc func goToMyPortFolio()
    {
        destination = storyboard?.instantiateViewController(withIdentifier:"MyPortfolioViewController") as! MyPortfolioViewController
        sideMenuController()?.setContentViewController(destination!)
    }
    
    //MARK:- goToContactUs
    
    @objc func goToContactUs()
    {
        destination = storyboard?.instantiateViewController(withIdentifier:"ContactUsViewController") as! ContactUsViewController
        sideMenuController()?.setContentViewController(destination!)
    }
    
    
    
    // MARK:- Perform Action On wishList
    @objc func goToMyWishList()
    {
       // self.view.makeToast("Work in Progress!")
       destination = storyboard?.instantiateViewController(withIdentifier:"WishListViewController") as! WishListViewController
       sideMenuController()?.setContentViewController(destination!)
    }
    
    @objc func goToMyInvestmentPlans()
    {
        destination = storyboard?.instantiateViewController(withIdentifier:"InvestmentPlansViewController") as! InvestmentPlansViewController
        sideMenuController()?.setContentViewController(destination!)
    }
    
    @objc func goToMyFarm()
    {
        destination = storyboard?.instantiateViewController(withIdentifier:"ViewController") as! ViewController
        sideMenuController()?.setContentViewController(destination!)
    }
    
    @objc func goToPremiumServices()
    {
        destination = storyboard?.instantiateViewController(withIdentifier:"PremiumServicesViewController") as! PremiumServicesViewController
        sideMenuController()?.setContentViewController(destination!)
    }
    
    @objc func logOut()
    {
       // ApiLogOut Integeration
        self.postLogOut()
    }
    
    // MARK:- Check Section is selected or not and Perform Actions
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer)
    {
        let headerView = sender.view as! UIView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        if (self.expandedSectionHeaderNumber == -1)
        {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        }
        else
        {
            if (self.expandedSectionHeaderNumber == section)
            {
                tableViewCollapeSection(section, imageView: eImageView!)
            }
            else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
   
    //MARK:- Method to expand a Selected Header
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView)
    {
        let sectionData = self.sectionItems[section] as! NSArray
        
        if (sectionData.count == 0)
        {
            self.expandedSectionHeaderNumber = -1;
            return;
        }
        else
        {
            UIView.animate(withDuration: 0.4, animations:
                {
                    imageView.transform = CGAffineTransform(rotationAngle: (180 * CGFloat(Double.pi)) / 360.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count
            {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexesPath, with: UITableViewRowAnimation.left)
            self.tableView!.endUpdates()
        }
  
    }
    
     //MARK:- Method to Collapse a Header cell which is already Expanded
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView)
    {
        let sectionData = self.sectionItems[section] as! NSArray
        
        self.expandedSectionHeaderNumber = -1;
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    //MARK:- Selection of a Row and deselection of a Row
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("The Section and row  is  == \(indexPath.section) \(indexPath.row)")
        if(indexPath.section == 5){
            if indexPath.row == 0{
                destination = storyboard?.instantiateViewController(withIdentifier:"AboutUsViewController") as! AboutUsViewController
                sideMenuController()?.setContentViewController(destination!)
            }
            if indexPath.row == 1{
                destination = storyboard?.instantiateViewController(withIdentifier:"HowItWorksViewController") as! HowItWorksViewController
                sideMenuController()?.setContentViewController(destination!)
            }
            if indexPath.row == 2{
                destination = storyboard?.instantiateViewController(withIdentifier:"SellToUsViewController") as! SellToUsViewController
                sideMenuController()?.setContentViewController(destination!)
            }
            if indexPath.row == 3{
                destination = storyboard?.instantiateViewController(withIdentifier:"KnowledBaseViewController") as! KnowledBaseViewController
                sideMenuController()?.setContentViewController(destination!)
            }
        if indexPath.row == 4{
            destination = storyboard?.instantiateViewController(withIdentifier:"BlogsViewController") as! BlogsViewController
            sideMenuController()?.setContentViewController(destination!)
            
        }else if indexPath.row == 5{
            destination = storyboard?.instantiateViewController(withIdentifier:"EventsViewController") as! EventsViewController
            sideMenuController()?.setContentViewController(destination!)
        }
    }
        
        
    }
    
   
    
    
    
    
    
}

