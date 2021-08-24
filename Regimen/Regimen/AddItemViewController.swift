//
//  AddItemViewController.swift
//  Regimen
//
//  Created by Alex Lai on 14/8/21.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate{
    
    public var completionHandler: ((String?)->Void)?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBAction func didTapSave(){
        NotificationCenter.default.post(name: Notification.Name("Text"), object: textField.text)
        dismiss(animated: true, completion: nil)
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        // Do any additional setup after loading the view.
    }
}
