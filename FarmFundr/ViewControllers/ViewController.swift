//
//  ViewController.swift
//  FarmFundr
//
//  Created by Shaik Baji on 10/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
     // MARK:- Outlets
    @IBOutlet weak var tblPropertyList : UITableView!
    @IBOutlet weak var txtType: LBZSpinner!
    @IBOutlet weak var txtCity: LBZSpinner!
    @IBOutlet weak var txtBudget: LBZSpinner!
    // MARK:- Class Variables
     var sideMenu : ENSideMenu?
     var apiGetPropertyListIncoming : ApiGetPropertyListIncomming?
    var apiGetPropertyListByParticularIdIncomming : ApiGetPropertyListByParticularIdIncomming?
    var apigetFiltersIncomming : ApiGetFilterDataIncomming?
    var addArray : [String] = []
    var contryArray : [String] = []
    var enumFilters : EnumFilters = .none
    var addressID : Int? = nil
    var contryId : Int? = nil
    var sortBy : String = ""
    var isAddressSelected : Bool = false
    var isContrySelected : Bool = false
    var isSortedBy : Bool = false
    // MARK:- Class Methods
    
     override func viewDidLoad()
        {
        super.viewDidLoad()
        getFilter()
        txtCity.delegate = self
        txtType.delegate = self
        txtBudget.delegate = self
      //  configureTxtData()
        tblPropertyList.estimatedRowHeight = 300
        tblPropertyList.rowHeight = UITableViewAutomaticDimension
        postGetPropertyList()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         postGetPropertyList()
        txtType.text = "Search by address"
        txtCity.text = "Select Country"
        txtBudget.text = "Sort by"
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    @IBAction func sideMenuButton(_ sender: UIButton)
    {
         showSideMenuView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        hideSideMenuView()
    }
 
    // MARK: - Integrate Api GetAllProperty List
    
    func postGetPropertyList(){
        let getPropertyRqst = ["userId" : (defaultLeoDefaultUser?.id!)!]
         HUD.show(.progress)
        WebServices.post(url: Api.getAllPropertyList.url, jsonObject: getPropertyRqst, completionHandler: { (response, _) in
            HUD.hide()
            if isApiSussess(response: response){
                self.apiGetPropertyListIncoming = ApiGetPropertyListIncomming(response: response)
             print("👍🏻👍🏻👍🏻👍🏻",self.apiGetPropertyListIncoming)
                DispatchQueue.main.async {
                     self.tblPropertyList.reloadData()
                }
            }else{
                self.view.makeToast(getMessage(response: response))
            }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast("ERROR In Getting Response")
            print("ERROR In Getting Response")
        }
    }
    
    // MARK: - Integerate GetPropertyList by IndividualId Api
    func postIndividualIdProperty(id : Int)  {
        let someRqst : [String : Any] = ["id" : id]
        HUD.show(.progress)
        WebServices.post(url: Api.getPropertyListIndividualId.url, jsonObject: someRqst, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response){
                self.apiGetPropertyListByParticularIdIncomming = ApiGetPropertyListByParticularIdIncomming(response: response as! [String : Any])
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PropertyDetailsViewController") as! PropertyDetailsViewController
       vc.propertyDetails = self.apiGetPropertyListByParticularIdIncomming
       self.navigationController?.pushViewController(vc, animated: true)
                print("RESPONSE===", self.apiGetPropertyListByParticularIdIncomming!)
            }else{
                self.view.makeToast(getMessage(response: response))
            }
        }) { (_, error) in
            print("ERROR====", error)
             HUD.hide()
             self.view.makeToast("Error in getting Response")
        }
        
    }
    
   // MARK: - Integerate AddWishList Api
    func postAddWishListApi( propertyId : Int){
        let someRqst : [String : Any] = ["userId":(defaultLeoDefaultUser?.id!)!,"propertyId":propertyId]
        HUD.show(.progress)
        WebServices.post(url: Api.addOrRemoveWishList.url, jsonObject: someRqst, completionHandler: { (_, response) in
         HUD.hide()
         self.view.makeToast(getMessage(response: response))
       //     if isApiSussess(response: response){
               self.postGetPropertyList()
          //  }else{
          //      self.view.makeToast(getMessage(response: response))
           // }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
        }
    }
    
   // MARK: - Integerate RemoveWishList Api
    func postRemoveWishList(wishlistId : Int){
        let removeWishListRqst = ["id":wishlistId]
        HUD.show(.progress)
        WebServices.post(url: Api.addOrRemoveWishList.url, jsonObject: removeWishListRqst, completionHandler: { (response, _) in
        HUD.hide()
        self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response){
                self.postGetPropertyList()
            }else{
                self.view.makeToast(getMessage(response: response))
            }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
        }
    }
   
    // MARK:- Configure textFieldData
    
   func configureTxtData(){
     txtType.updateList(addArray)
     txtCity.updateList(contryArray)
    let shortByArr = ["asc","desc"]
    txtBudget.updateList(shortByArr)
    }
    // MARK: - getFilter Api integeration
    
    func getFilter(){
        WebServices.get(url: Api.getFilter.url, completionHandler: { (response, _) in
            self.apigetFiltersIncomming = ApiGetFilterDataIncomming(response: response as! NSDictionary)
            print("🥝🥝🥝",self.apigetFiltersIncomming)
            self.apigetFiltersIncomming?.filterData.map({ data in
                data.addresses.map({ adress  in
                    self.addArray.append(adress.address!)
                })
    data.contries.map({ contries in
        self.contryArray.append(contries.name!)
                })
            })
            self.configureTxtData()
        }) { (error, _) in
           print("ERROR")
        }
    }
    
    // MARK:- Post ApplyFilter Api Integeration
    func postApplyFilter(addressId : Int? = nil , sortBy : String? = "" , countryId : Int? = nil ){
        let filterRqst : [String : Any] = ["address" : addressId as Any , "sort_by" : sortBy as Any , "countryId" : countryId as Any , "userId" : (defaultLeoDefaultUser?.id)!]
        HUD.show(.progress)
        WebServices.post(url: Api.applyFilter.url, jsonObject: filterRqst, completionHandler: { (response, _) in
            HUD.hide()
            self.apiGetPropertyListIncoming?.propertyDetails.removeAll()
            print("🇮🇳", response)
            self.apiGetPropertyListIncoming = ApiGetPropertyListIncomming(response: response)
            DispatchQueue.main.async {
                self.tblPropertyList.reloadData()
            }
        }) { (error, _) in
            
        }
    }
}

// MARK :- Extension for Filter Conditions
extension ViewController{
    func getFilters(enumFilters : EnumFilters){
        switch enumFilters {
        case .address:
            print("address")
          self.postApplyFilter(addressId: self.addressID)
        case .country:
            print("country")
           self.postApplyFilter( countryId: self.contryId)
        case .sortBy:
            print("sortBy")
             self.postApplyFilter( sortBy: self.sortBy)
        case .addressNContry:
            print("addressNContry")
           self.postApplyFilter(addressId: self.addressID, countryId: self.contryId)
        case .addressNSortBy:
            print("addressNContry")
           self.postApplyFilter(addressId: self.addressID, sortBy: self.sortBy)
        case .countryNsortBy:
            print("countryNsortBy")
           self.postApplyFilter(sortBy: self.sortBy, countryId: self.contryId)
        case .all:
            print("all")
           self.postApplyFilter(addressId: addressID, sortBy: sortBy, countryId: contryId)
        case .none:
            print("none")
        default:
            print("fuyjgfue")
        }
        
        
    }
}

// MARK:- LBZSpinner delegate

extension ViewController : LBZSpinnerDelegate{
    
    func spinnerChoose(_ spinner: LBZSpinner, index: Int, value: String) {
            print("Spinner : \(spinner) : { Index : \(index) - \(value) }")
        if spinner == txtType{
                      if txtType.selectedIndex == spinner.selectedIndex{
            self.isAddressSelected = true
            self.addressID = self.apigetFiltersIncomming?.filterData?.addresses[index].id
            //                self.enumFilters = .address
            //                self.getFilters(enumFilters: enumFilters)
             checkFilters()
            print("id===", self.addressID)
            
                        }
        }
        if spinner == txtCity{
            if txtCity.selectedIndex == spinner.selectedIndex{
                self.isContrySelected = true
                self.contryId = self.apigetFiltersIncomming?.filterData?.contries[index].id
                //                self.enumFilters = .address
                //                self.getFilters(enumFilters: enumFilters)
                checkFilters()
                print("id===", self.addressID)
                
            }
        }
        if spinner == txtBudget{
            if txtBudget.selectedIndex == spinner.selectedIndex{
                self.isSortedBy = true
                self.sortBy = value
                checkFilters()
            }
        }
      //checkFilters()
    }
  
    // MARK : - Filter Conditions
    
    func checkFilters(){
        if isAddressSelected == true && isContrySelected == true && isSortedBy == true{
            enumFilters = .all
            getFilters(enumFilters: enumFilters)
        }else if isAddressSelected == true{
            enumFilters = .address
            getFilters(enumFilters: enumFilters)
        }else if isContrySelected == true{
            enumFilters = .country
            getFilters(enumFilters: enumFilters)
        }else if isSortedBy == true{
            enumFilters = .sortBy
            getFilters(enumFilters: enumFilters)
        }else if isAddressSelected == true && isContrySelected == true && isSortedBy == false{
            enumFilters = .addressNContry
            getFilters(enumFilters: enumFilters)
        }else if isAddressSelected == true && isSortedBy == true && isContrySelected == false{
            enumFilters = .addressNSortBy
            getFilters(enumFilters: enumFilters)
        }else if isContrySelected == true && isSortedBy == true && isAddressSelected == false {
            enumFilters = .countryNsortBy
            getFilters(enumFilters: enumFilters)
        }
        
    }
    
    
    
    
    
    
}




// MARK:- UITableViewDelegate and DataSources

extension ViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiGetPropertyListIncoming?.propertyDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let somePropertyList = apiGetPropertyListIncoming?.propertyDetails[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyListTableViewCell.identifier) as! PropertyListTableViewCell
         cell.configureData(apiGetPropertyList: somePropertyList!)
        cell.closureDidTapOnOpenBtn = { propertyData in
            self.postIndividualIdProperty(id: propertyData.id!)
        }
        cell.closureDidTappedOnWishList = { propertyData in
            if propertyData.wishlistId == 0 {
                self.postAddWishListApi(propertyId:propertyData.id!)
               // cell.imgWishList.image = UIImage(named: "like")
            }else{
                // remove Api
                self.postRemoveWishList(wishlistId:propertyData.wishlistId!)
            }
            
        }
      return cell
    }
}

// MARK:- UITableViewCell Class

class PropertyListTableViewCell : UITableViewCell{
    //MARK:-  Outlets
    @IBOutlet weak var imgLand : UIImageView!
    @IBOutlet weak var imgOwner : UIImageView!
    @IBOutlet weak var lblAddTypeName : UILabel!
    @IBOutlet weak var lblAddress : UILabel!
    @IBOutlet weak var lblTotalfund : UILabel!
    @IBOutlet weak var lblFunded : UILabel!
    @IBOutlet weak var lblROI : UILabel!
     @IBOutlet weak var lblDaysLeft : UILabel!
     @IBOutlet weak var imgWishList : UIImageView!
     @IBOutlet weak var viewProgressBar : LinearProgressBar!
    //MARK:-  Class Variables
    static let identifier = "PropertyListTableViewCell"
    var apiGetPropertyList : ApiGetPropertyListIncomming.PropertyDetail?
    var closureDidTapOnOpenBtn : ((ApiGetPropertyListIncomming.PropertyDetail) -> Void)?
    var closureDidTappedOnWishList : ((ApiGetPropertyListIncomming.PropertyDetail) -> Void)?
    func configureData(apiGetPropertyList :ApiGetPropertyListIncomming.PropertyDetail){
        self.apiGetPropertyList = apiGetPropertyList
        lblROI.text = String(format: "%.2f", apiGetPropertyList.roi ?? "NG") + "%"
        lblAddTypeName.text = "by:" + apiGetPropertyList.owner!
        lblAddress.text = apiGetPropertyList.address
        lblFunded.text = String(apiGetPropertyList.funded!) + "%"
        lblDaysLeft.text = "\(apiGetPropertyList.diffDate!)" 
        lblTotalfund.text = "$" + apiGetPropertyList.target!
        viewProgressBar.progressValue = CGFloat(apiGetPropertyList.total_fund!)
       // let url = URL(string:"http://www.apple.com/euro/ios/ios8/a/generic/images/og.png")
        imgOwner.load(url: apiGetPropertyList.ownerPicUrl)
        if apiGetPropertyList.wishlistId == 0{
            imgWishList.image = UIImage(named: "heart")
        }else{
           imgWishList.image = UIImage(named: "like")
        }
        //heart //like
       imgLand.load(url: apiGetPropertyList.galleryPicUrl )
        //String(apiGetPropertyList.total_fund!)
    
    }

    // MARK:- Action OpenBtn

    @IBAction func actionOpenBtn(_ sender : UIButton){
        closureDidTapOnOpenBtn?(apiGetPropertyList!)
    }
    
    @IBAction func actionWishListBtn(_ sender : UIButton){
        closureDidTappedOnWishList?(apiGetPropertyList!)
    }

}
