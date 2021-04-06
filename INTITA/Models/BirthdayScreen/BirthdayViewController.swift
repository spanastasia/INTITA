//
//  BirthdayViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 29.03.2021.
//

import UIKit

class BirthdayViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var birthdaySelectorLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var currentBirthdayLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var coordinator: BirthdayCoordinator?
    var viewModel: BirthdayViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBirthdaySelectorLabel()
        setupDatePicker()
        setupDoneButton()
        setupCurrentBirthdayLabel()
        
        datePicker?.addTarget(self, action: #selector(getDateFromPicker), for: .valueChanged)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        coordinator?.returnToSettingsScreen()
    }
    
    @objc func getDateFromPicker() {

        view.endEditing(true)
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        viewModel.setData(didSelectedDate: formater.string(from: datePicker.date))
    }
    
    func setupCurrentBirthdayLabel() {
        currentBirthdayLabel.text = viewModel?.selectedDate
        currentBirthdayLabel.font = UIFont(name: "MyriadPro-Regular", size: 18)
        currentBirthdayLabel.textColor = .black
    }
    
    func setupBirthdaySelectorLabel() {
        birthdaySelectorLabel.shadowed()
        birthdaySelectorLabel.text = "birthday".localized
        birthdaySelectorLabel.font = .primaryFontRegular
        birthdaySelectorLabel.textColor = .primaryColor
    }
    
    func setupDoneButton() {
        doneButton.shadowed()
        doneButton.setTitle("done".localized, for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "MyriadPro-Regular", size: 24)
        doneButton.rounded(cornerRadius: 15.0)
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = NSCalendar.current.date(byAdding: .year, value: -3, to: Date())
        datePicker.date = viewModel.dateFromString ?? Date()
    }
    
}
