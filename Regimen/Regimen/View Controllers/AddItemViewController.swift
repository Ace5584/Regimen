//
//  AddItemViewController.swift
//  Regimen
//
//  Created by Alex Lai on 14/8/21.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate{
    
    // Name of the Task | Time Based or Task based | Time | Completed or not | Days Allocated
    
    public var completionHandler: ((String?)->Void)?
    public var isTimeBased = true
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBAction func didTapSave(){
        var taskType = "Time Based"
        if isTimeBased{
            taskType = "Time Based"
        }
        else{
            taskType = "Task Based"
        }
        NotificationCenter.default.post(name: Notification.Name("Text"), object: [textField.text ?? "", taskType])
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            isTimeBased = true
            print(isTimeBased)
        }
        if sender.selectedSegmentIndex == 1{
            isTimeBased = false
            print(isTimeBased)
        }
        
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
