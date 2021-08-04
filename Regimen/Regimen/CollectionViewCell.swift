//
//  CollectionViewCell.swift
//  Regimen
//
//  Created by Alex Lai on 1/8/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
//    @IBOutlet weak var textLbl: UILabel!
//    func setLabel(label:String) {
//        textLbl.text = label
//    }
    
    @IBOutlet weak var circleProgressView: CircularProgressBar!
    
    func setProgressView(){
        circleProgressView.trackClr = UIColor.cyan
        circleProgressView.progressClr = UIColor.purple
        circleProgressView.setProgressWithAnimation(duration: 5, value: 0.5)
    }
}
