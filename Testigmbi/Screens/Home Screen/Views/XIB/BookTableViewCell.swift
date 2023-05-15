//
//  BookTableViewCell.swift
//  Testigmbi
//
//  Created by EZAZ AHAMD on 09/02/23.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var image_icon:UIImageView!
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var sub_title:UILabel!
    @IBOutlet weak var rate_lbl:UILabel!
    @IBOutlet weak var location_lbl:UILabel!
    @IBOutlet weak var collactionVIew:UICollectionView!
    @IBOutlet weak var view_bg:UIView!
 
    var loadData : Listed?{
        didSet{
            config()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collactionVIew.register(UINib(nibName: "TimeSloteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeSloteCollectionViewCell")
        collactionVIew.delegate = self
        collactionVIew.dataSource = self
        view_bg.layer.cornerRadius = 5
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(){
        guard let loadData = loadData else {
            return
        }
        image_icon.setImage(with: loadData.image ?? "")
        title.text = loadData.business_name
        sub_title.text = loadData.description
        rate_lbl.text = (loadData.rating ?? "") + "/5"
        location_lbl.text = "Location: " + (loadData.address ?? "")
        
    }
    
    
    
    
}


extension BookTableViewCell:  UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadData?.time_available?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeSloteCollectionViewCell", for: indexPath) as? TimeSloteCollectionViewCell else{
            return UICollectionViewCell()
         }
        cell.loadData = loadData?.time_available?[indexPath.item]
    return cell
    }
    
    
}
extension BookTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

            let cellHeight = 40
            let cellWidth = (collectionView.bounds.size.width) / 5 // 2 count of colomn to show
            return CGSize(width: CGFloat(cellWidth), height: CGFloat(cellHeight))

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      
            return 10.0
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
