//
//  BirthdayViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 29.03.2021.
//

import UIKit

class BirthdayViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var nameScreenLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var coordinator: BirthdayCoordinator?
    var viewModel: BirthdayViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNameScreenLabel()
        setupDatePicker()
        setupDoneButton()
        setupDateTextField()
        
        datePicker?.addTarget(self, action: #selector(getDateFromPicker), for: .valueChanged)

    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        coordinator?.returnToSettingsScreen()
    }
    
    @objc func getDateFromPicker() {

        let formater = DateFormatter()
        view.endEditing(true)
        formater.dateFormat = "yyyy-MM-dd"
        dateTextField.text = formater.string(from: datePicker.date)
        viewModel.setData(didSelectedDate: formater.string(from: datePicker.date))
    }
    
    func setupDateTextField() {
        dateTextField.text = viewModel?.selectedDate
    }
    
    func setupNameScreenLabel() {
        nameScreenLabel.text = "birthday".localized
        nameScreenLabel.font = UIFont(name: "birthday".localized, size: 16)
    }
    
    func setupDoneButton() {
        doneButton.setTitle("done".localized, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .inline
    }
    
}
