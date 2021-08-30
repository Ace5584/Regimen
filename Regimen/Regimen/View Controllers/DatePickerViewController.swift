//
//  DatePickerViewController.swift
//  Regimen
//
//  Created by Alex Lai on 31/8/21.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var dateTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
        dateTextField.text = formatDate(date: Date())
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        dateTextField.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
}
