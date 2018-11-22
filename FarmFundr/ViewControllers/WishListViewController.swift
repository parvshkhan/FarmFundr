//
//  WishListViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 17/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tblWishList : UITableView!
    @IBOutlet weak var viewBookNow : UIView!
    //MARK:- Class Variables
    var apigetWishListIncomming : ApigetWishListIncomming?
    var wishListIdArr : [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        postGetWishList()
        // Do any additional setup after loading the view.
    }
 
    //MARK :- Actions
    
    @IBAction func actionOpenSideMenu(_ sender : UIButton){
        toggleSideMenuView()
    }
    
    @IBAction func actionCloseBtn(_ sender : UIButton){
        let initialViewControlleripad : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SideNavigationController") as! SideNavigationController
        //      self.view.window = self.view.bounds
        self.view.window?.rootViewController = initialViewControlleripad
        self.view.window?.makeKeyAndVisible()
        
    }
    
    //MARK:- Methods
    
    //MARK:- GetWishList Api Integeration
    func postGetWishList(){
    let someRqst : [String : Any] = ["userId": (defaultLeoDefaultUser?.id!)!]
      //  HUD.show(.progress)
        WebServices.post(url: Api.getWishList.url, jsonObject: someRqst, completionHandler: { (response, _) in
          //  HUD.hide()
            self.view.makeToast(getMessage(response: response))
            self.apigetWishListIncomming = ApigetWishListIncomming(response: response)
            print("WISHLIST===",self.apigetWishListIncomming)
            DispatchQueue.main.async {
                self.tblWishList.reloadData()
            }
            
        }) { (error, _) in
           // HUD.hide()
        }
    }
  
    // Methode: Rmove Item
    func getIndex(id : Int) -> Int{
        var index : Int = 0
        for i in 0..<(wishListIdArr.count){
            if id == wishListIdArr[i]{
                index = i
                return index
            }
        }
        return index
    }
}

extension WishListViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apigetWishListIncomming?.wishListItems.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.identifier) as! WishListTableViewCell
        let someWishData = apigetWishListIncomming?.wishListItems[indexPath.row]
        cell.configureWishList(wishListObject: someWishData!)
        cell.closureDidTapOnwish = { id , selection in
            if selection == true{
                 cell.imgSelect.image = UIImage(named: "circleCheck")
                 self.wishListIdArr.append(id)
            }else{
                //Romove Book item
                cell.imgSelect.image = UIImage(named: "circleUncheck")
                self.wishListIdArr.remove(at: self.getIndex(id: id))
            }
            if self.wishListIdArr.count > 0{
                self.viewBookNow.isHidden = false
            }else{
               self.viewBookNow.isHidden = true
            }
        }
    return cell
    }
}

//MARK:- TableViewCell Class

class WishListTableViewCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var lblAdd : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblfunded : UILabel!
    @IBOutlet weak var lblRoi : UILabel!
    @IBOutlet weak var lblDaysLeft : UILabel!
    @IBOutlet weak var imgLand : UIImageView!
     @IBOutlet weak var imgSelect : UIImageView!
    //MARK:- Variables
    static let identifier = "WishListTableViewCell"
    var wishListObject : ApigetWishListIncomming.WishListItem?
    var closureDidTapOnwish : ((Int , Bool) -> Void)?
    //MARK:- Actions
    
    
    //MARK:- Methods
    func configureWishList(wishListObject : ApigetWishListIncomming.WishListItem){
      self.wishListObject = wishListObject
        lblAdd.text = wishListObject.address
        lblRoi.text = "\(String(describing: wishListObject.roi!))" + "%"
        lblfunded.text = "\(String(describing: wishListObject.funded!))" + "%"
        lblPrice.text = "$\(String(describing: wishListObject.target!))"
        lblDaysLeft.text = "\(String(describing: wishListObject.diffDate!))"
        let url = wishListObject.galleryImg?.replacingOccurrences(of: " ", with: "")
        print("URLIMAGE===", url)
        let someURl = URL.init(string: url ?? "http://smartit.ventures/farm/Agricultural_project/public/PropertyThumbnail/1540214504photo-1500076656116-558758c991c1.jpg")!
       imgLand.load(url: someURl)
    }
    
    @IBAction func  actionCheckButton(_ sender : UIButton){
        sender.isSelected = !sender.isSelected
        closureDidTapOnwish?((wishListObject?.wishlistId!)!, sender.isSelected)
    }

}

