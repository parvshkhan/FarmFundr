//
//  Demo.swift
//  FarmFundr
//
//  Created by Shaik Baji on 12/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
// 1272.5

import UIKit

class RowCropFarmCell:UITableViewCell
{
    
}

class RowCropFarmVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier:"RowCropFarmCell", for:indexPath) as! RowCropFarmCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 1090
        
    }
    @IBAction func menuBtnTapped(_ sender: UIButton)
    {
        showSideMenuView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        hideSideMenuView()
    }
    
}
