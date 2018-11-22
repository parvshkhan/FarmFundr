//
//  PropertyDetailsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 03/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PropertyDetailsViewController: ButtonBarPagerTabStripViewController {
    //MARK:- Outlets
    @IBOutlet weak var lblAdd : UILabel!
    @IBOutlet weak var lblOwner : UILabel!
    @IBOutlet weak var imgOwnerPic : UIImageView!
    @IBOutlet weak var imgGallery1 : UIImageView!
    @IBOutlet weak var imgGallery2 : UIImageView!
    @IBOutlet weak var imgGallery3 : UIImageView!
    @IBOutlet weak var tblGallary: UITableView!
    @IBOutlet weak var imgWishList : UIImageView!
    //MARK:- Class Variables
    var propertyDetails : ApiGetPropertyListByParticularIdIncomming?
    static var propertyInfo : ApiGetPropertyListByParticularIdIncomming?
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgArr = getImgArray(gallery: (propertyDetails?.propertyDetails?.galleryImg)!)
        lblAdd.text = propertyDetails?.propertyDetails?.address
        print(lblAdd.text)
        lblOwner.text = propertyDetails?.propertyDetails?.owner
        imgOwnerPic.load(url: URL(string: propertyDetails?.propertyDetails?.ownerImg! ?? "http://192.168.0.40/Agricultural_project/public/ownerThumbnail/1538051575expert-1.png")!)
//        imgGallery1.animationImages = imgArr
//        imgGallery1.animationDuration = 0.1
        pagerSetUp()
        DispatchQueue.main.async {
            self.tblGallary.reloadData()
        }
        print("PropertyDetails===", PropertyDetailsViewController.propertyInfo = propertyDetails)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        lblAdd.text = propertyDetails?.propertyDetails?.address
        lblOwner.text = propertyDetails?.propertyDetails?.owner
        if propertyDetails?.propertyDetails?.wishlistId == 0{
            imgWishList.image = UIImage(named: "heart")
        }else{
           imgWishList.image = UIImage(named: "like")
        }
        pagerSetUp()
        print("PropertyDetails===", PropertyDetailsViewController.propertyInfo = propertyDetails)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OverViewPropertyViewController")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocumentsViewController")
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "investmentCaseViewController")
        let child_4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FarmDetailsViewController")
        return [child_1, child_2,child_3,child_4]
    }
    
    @IBAction func actionWishListBtn(_ sender : UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            imgWishList.image = UIImage(named: "like")
            postAddWishListApi(propertyId: (propertyDetails?.propertyDetails?.id)!)
        }else{
            postRemoveWishList(wishlistId: (propertyDetails?.propertyDetails?.wishlistId)!)
            imgWishList.image = UIImage(named: "heart")
        }
    }
    
    //MARK:- Action Share Button
    
    @IBAction func actionShareBtn(_ sender : UIButton){
     //   let custId = defaultLeoDefaultUser?.id
        let textToShare = "FarmPartner is awesome! application for buying Property Check out this website about it!"
        if let myWebsite = NSURL(string: "http://smartit.ventures/farm/Agricultural_project/public/farm") { // add customer id after /
            let objectsToShare = [textToShare, myWebsite ] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            //
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        
    }
    
    }
    // MARK: - Integerate AddWishList Api
    func postAddWishListApi( propertyId : Int){
        let someRqst : [String : Any] = ["userId":(defaultLeoDefaultUser?.id!)!,"propertyId":propertyId]
        HUD.show(.progress)
        WebServices.post(url: Api.addOrRemoveWishList.url, jsonObject: someRqst, completionHandler: { (_, response) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            
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
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
        }
    }

    
    @IBAction func actionBackBtn(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK:- Pager SetUp
    func pagerSetUp(){
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = AppColors.green.color
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 0.1
     //   settings.style.buttonBarHeight
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarHeight = 0.1
        settings.style.buttonBarItemTitleColor = .gray
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = AppColors.green.color
        }
    }
   
    // MARK:- get UIImageArr From array of string
    func getImgArray(gallery : [String]) -> [UIImage]{
        var imgArr : [UIImage] = []
        _ = gallery.map({ urlString in
            let absoluteUrlStr = urlString.trimmingCharacters(in: .whitespaces)
            let gallaryURl = URL(string: absoluteUrlStr) ?? URL(string: "http://smartit.ventures/farm/Agricultural_project/public/PropertyThumbnail/15402146501.jpg")
            let imageData = try? Data(contentsOf: gallaryURl!)
            let image = UIImage(data: imageData!)!
            imgArr.append(image)
        })
        print("imgArr===",imgArr)
       return imgArr
    }

}

extension PropertyDetailsViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell") as! GalleryTableViewCell
        cell.imgStringArr = (propertyDetails?.propertyDetails?.galleryImg)!
        return cell
    }
    
}


