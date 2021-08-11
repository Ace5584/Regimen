//
//  AddViewController.swift
//  CollectionViewProject
//
//  Created by Alex Lai on 10/8/21.
//

import UIKit

class AddViewController: UIViewController {

    
    public var completionHandler: ((String?)->Void)?
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBAction func didTapSave(){
        NotificationCenter.default.post(name: Notification.Name("text"), object: emojiTextField.text)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
