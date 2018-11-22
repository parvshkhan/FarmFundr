//
//  DocumentsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 03/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DocumentsViewController: UIViewController , IndicatorInfoProvider  {

    // MARK :- Outlets
    @IBOutlet weak var tblDocList : UITableView!
    
    // MARK:- Class Variables
    var propertyDetails : ApiGetPropertyListByParticularIdIncomming?
    var documetStrArr : [String] = []
    var titleStrArr : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     /*   if let parent = self.parent as? PropertyDetailsViewController{
            propertyDetails = parent.propertyDetails
        }*/
          propertyDetails = PropertyDetailsViewController.propertyInfo
        _ = propertyDetails?.propertyDetails.map({ property in
            documetStrArr = property.document_file ?? []
            titleStrArr = property.document_file_name ?? []
        })
        tblDocList.estimatedRowHeight = 80
        tblDocList.rowHeight = UITableViewAutomaticDimension
        
        DispatchQueue.main.async {
            self.tblDocList.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    // MARK:- XLPagerTab Protocol
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        print("This is Chide two Class")
        return IndicatorInfo(title: "DOCUMENT")
    }

}

extension DocumentsViewController : UITableViewDelegate , UITableViewDataSource{
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documetStrArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DocumentListTableViewCell.id) as! DocumentListTableViewCell
        let some = titleStrArr[indexPath.row]
        cell.lblTile.text = some
        return cell
    }
    
}

class DocumentListTableViewCell : UITableViewCell{
    static let id = "DocumentListTableViewCell"
    @IBOutlet weak var lblTile : UILabel!
}
