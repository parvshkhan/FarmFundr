//
//  BlogsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 08/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit
class BlogsViewController: UIViewController {
    //MARK:- Outlets
    
    @IBOutlet weak var tblView: UITableView!
    
    //MARK:- Class Variables
    var apiGetBlosIncomming : ApiGetAllBlogListIncomming?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postGetBlogs()
        tblView.estimatedRowHeight = 200
        tblView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
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
    
    // MARK:- GetBlogApi Integeration
    func postGetBlogs(){
        let someRqst = ["":""]
        HUD.show(.progress)
        WebServices.post(url: Api.getBlogsList.url, jsonObject: someRqst, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response){
                self.apiGetBlosIncomming = ApiGetAllBlogListIncomming(response: response)
              print("RESPONSE===", self.apiGetBlosIncomming)
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
        }) { (error , _) in
            HUD.hide()
             self.view.makeToast(error.localizedDescription)
            print("ERROR ===" , error)
        }
    }
}

extension BlogsViewController : UITableViewDelegate , UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiGetBlosIncomming?.blogDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BlogsListTableViewCell.identifier) as! BlogsListTableViewCell
        let someBlog = apiGetBlosIncomming?.blogDetails[indexPath.row]
        cell.configure(blogData:someBlog!)
        cell.closureDidTapOnReadBtn = { state in
            if state == true{
                cell.blDescription.numberOfLines = 0
                cell.blDescription.lineBreakMode = .byWordWrapping
                self.tblView.reloadData()
            }else{
                cell.blDescription.numberOfLines = 4
                cell.blDescription.lineBreakMode = .byTruncatingTail
                self.tblView.reloadData()
            }
            
        }
        return cell
    }
    
}

// MARK:- Blogs List Cells
class BlogsListTableViewCell : UITableViewCell{
    
    //MARK:- Outlets
    @IBOutlet weak var imgLand: UIImageView!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPostedBy: UILabel!
    @IBOutlet weak var lblTitles: UILabel!
    @IBOutlet weak var blDescription: UILabel!
    
    //MARK:- Variables
    static let identifier = "BlogsListTableViewCell"
    var apiBlogData : ApiGetAllBlogListIncomming.BlogDetail?
    var closureDidTapOnReadBtn : ((Bool) -> Void)?
    // MARK:- Method To configure Cell Data
    func configure(blogData : ApiGetAllBlogListIncomming.BlogDetail) {
        self.apiBlogData = blogData
        lblPostedBy.text = apiBlogData?.title
        lblTitles.text = "By:" + (apiBlogData?.post_by)!
        blDescription.text = apiBlogData?.description?.htmlToString
        imgLand.load(url: (apiBlogData?.imageUrl)!)
        let dateNTimeStr = apiBlogData?.created_at?.split(separator: " ")
        let dateStr = dateNTimeStr![0]
        let date = stringToDatestr(date: String(dateStr))
        print("DATE==", date)
        let dateYr = date.split(separator: ",")
        lblDate.text = String(dateYr[0])
        lblYear.text = String(dateYr[1])
    }
   
    @IBAction func actionReadMoreBtn(_ sender : UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
           closureDidTapOnReadBtn?(true)
        }else{
           closureDidTapOnReadBtn?(false)
        }
    }
    
}
