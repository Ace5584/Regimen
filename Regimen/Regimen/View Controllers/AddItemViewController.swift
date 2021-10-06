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
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeSelectionView: UIView!
    let datePicker = UIDatePicker()
    
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
            timeSelectionView.isHidden = false
        }
        if sender.selectedSegmentIndex == 1{
            isTimeBased = false
            timeSelectionView.isHidden = true
        }
        
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func createDatePicker() {
        dateTextField.textAlignment = .center
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([btnDone], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .countDownTimer
        dateTextField.inputView = datePicker
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        createDatePicker()
        // Do any additional setup after loading the view.
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        formatter.dateFormat = "hh:mm"
        
        dateTextField.text = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }
    
}
