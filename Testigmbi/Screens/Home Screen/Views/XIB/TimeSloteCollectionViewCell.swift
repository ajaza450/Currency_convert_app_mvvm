//
//  TimeSloteCollectionViewCell.swift
//  Testigmbi
//
//  Created by EZAZ AHAMD on 09/02/23.
//

import UIKit

class TimeSloteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title_time_lbl:UILabel!
    @IBOutlet weak var view_bg:UIView!

    var loadData : TimeAvailable?{
        didSet{
            config()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_bg.layer.cornerRadius = 5
    }

    
    func config(){
        guard let loadData = loadData else {
            return
        }
        title_time_lbl.text = loadData.time
    }
    
}





final class ContentSizedCollectionView: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: collectionViewLayout.collectionViewContentSize.height)
    }
}
