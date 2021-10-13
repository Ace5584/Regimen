//
//  DetailViewController.swift
//  Regimen
//
//  Created by Alex Lai on 16/8/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskType: UILabel!
    @IBOutlet weak var progressCircle: CircularProgressBar!
    var selectedData: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        taskName.text = selectedData?[0]
        taskType.text = selectedData?[1]
        progressCircle.trackClr = UIColor.systemTeal
        progressCircle.progressClr = UIColor.systemBlue
        if selectedData?[3] == "false" {
            progressCircle.setProgressWithAnimation(duration: 0, value: 0.01)
        }
        else {
            progressCircle.setProgressWithAnimation(duration: 5, value: 1)
        }
    }
    
    private func isKeyPresentInUserDefaults(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
}
