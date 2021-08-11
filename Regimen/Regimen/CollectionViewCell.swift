//
//  CollectionViewCell.swift
//  Regimen
//
//  Created by Alex Lai on 1/8/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    // Description
    @IBOutlet weak var textLbl: UILabel!
    func setLabel(label:String) {
        textLbl.text = label
    }
    
    // Description
    @IBOutlet weak var circleProgressView: CircularProgressBar!
    
    // Description
    @IBOutlet weak var checkMarkLabel: UILabel!
    
    // Description
    func setProgressView(){
        circleProgressView.trackClr = UIColor.systemTeal
        circleProgressView.progressClr = UIColor.systemBlue
        circleProgressView.setProgressWithAnimation(duration: 5, value: 0.5)
    }
    
    // Description
    var isInEditingMode: Bool = false {
        didSet {
            checkMarkLabel.isHidden = !isInEditingMode
        }
    }
    
    // conditions for when the cell is selected
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                checkMarkLabel.text = isSelected ? "✓" : ""
            }
        }
    }
    
    // This function sets up the check label
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.checkMarkLabel.layer.cornerRadius = 15
        self.checkMarkLabel.layer.masksToBounds = true
        self.checkMarkLabel.layer.borderColor = UIColor.white.cgColor
        self.checkMarkLabel.layer.borderWidth = 1.0
        self.checkMarkLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    // Preapres the cell for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        checkMarkLabel.isHidden = !isInEditingMode
    }
}
