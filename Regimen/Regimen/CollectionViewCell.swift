//
//  CollectionViewCell.swift
//  Regimen
//
//  Created by Alex Lai on 1/8/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textLbl: UILabel!
    func setLabel(label:String) {
        textLbl.text = label
    }
    
    @IBOutlet weak var circleProgressView: CircularProgressBar!
    
    @IBOutlet weak var checkMarkLabel: UILabel!
    
    func setProgressView(){
        circleProgressView.trackClr = UIColor.systemTeal
        circleProgressView.progressClr = UIColor.systemBlue
        circleProgressView.setProgressWithAnimation(duration: 5, value: 0.5)
    }
    
    var isInEditingMode: Bool = false {
        didSet {
            checkMarkLabel.isHidden = !isInEditingMode
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                checkMarkLabel.text = isSelected ? "✓" : ""
            }
        }
    }
}
