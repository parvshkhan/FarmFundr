//
//  PropertiesVC.swift
//  FarmFundr
//
//  Created by Shaik Baji on 11/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

struct propertyStruct
{
    var image:UIImage!
    var image2:UIImage!
    var minInvestment:String!
    var project:String!
    var heading:String!
}

class PropertiesCV:UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var minInvestmentLabel: UILabel!
    @IBOutlet weak var projectReturnLabel: UILabel!
}
class PropertiesVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    var structArray = [propertyStruct]()
    
 override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        structArray = [propertyStruct(image:#imageLiteral(resourceName: "image1"), image2:#imageLiteral(resourceName: "img_39"), minInvestment:"$30,000", project:"13%",heading:"Almond Orchard"),propertyStruct(image:#imageLiteral(resourceName: "image2"), image2:#imageLiteral(resourceName: "img_39"), minInvestment:"$10,000", project:"6%-10%",heading:"Row Crop Farm"),propertyStruct(image:#imageLiteral(resourceName: "image4"), image2:#imageLiteral(resourceName: "img_39"), minInvestment:"$10,000", project:"8%-15%",heading:"Pistachio Development")]
        
 }
    @IBAction func menuBtnTapped(_ sender: UIButton)
    {
        showSideMenuView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right:5)
        layout.itemSize = CGSize(width:(self.view.frame.size.width)/2-9, height:254)
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"PropertiesCV", for: indexPath) as! PropertiesCV
        
        cell.imageView.image = structArray[indexPath.row].image
        cell.image2.image = structArray[indexPath.row].image2
        cell.minInvestmentLabel.text = structArray[indexPath.row].minInvestment
        cell.projectReturnLabel.text = structArray[indexPath.row].project
        cell.headingLabel.text = structArray[indexPath.row].heading
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if(indexPath.row==0)
        {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"AlmondOrchardVC") as! AlmondOrchardVC
        self.navigationController?.pushViewController(vc, animated: true)
       }
        else if(indexPath.row==1)
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"RowCropFarmVC") as! RowCropFarmVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"PistachioDevelopmentVC") as! PistachioDevelopmentVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        hideSideMenuView()
    }

   
}
