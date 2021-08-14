//
//  AddItemViewController.swift
//  Regimen
//
//  Created by Alex Lai on 14/8/21.
//

import UIKit

class AddItemViewController: UIViewController {
    
    public var completionHandler: ((String?)->Void)?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBAction func didTapSave(){
        NotificationCenter.default.post(name: Notification.Name("Text"), object: textField.text)
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
