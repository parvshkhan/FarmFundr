//
//  GalleryTableViewCell.swift
//  FarmFundr
//
//  Created by Anupriya on 17/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var collectionImg : UICollectionView!
    // Class Variable
    var imgStringArr : [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionImg.delegate = self
        collectionImg.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension GalleryTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgStringArr.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gallaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell" , for: indexPath) as! GalleryCollectionViewCell
        let imgString1 = imgStringArr[indexPath.row]
        gallaryCell.imgView.load(url: URL(string: imgString1) ?? URL(string: "http://192.168.0.40/Agricultural_project/public/PropertyThumbnail/1538051576Agricultural-Land.jpg")!)
        return gallaryCell
    }

}

class GalleryCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var imgView : UIImageView!
}
