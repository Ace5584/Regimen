//
//  DetailViewController.swift
//  Regimen
//
//  Created by Alex Lai on 16/8/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedData: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedData!)
        // Do any additional setup after loading the view.
    }
    
    private func isKeyPresentInUserDefaults(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
}
