//
//  DetailViewController.swift
//  CollectionViewProject
//
//  Created by Alex Lai on 8/8/21.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedData: String?
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataLabel.text = selectedData
        // Do any additional setup after loading the view.
    }
    
    

}
