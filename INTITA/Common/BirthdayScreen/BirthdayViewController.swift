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
    @IBOutlet weak var currentBirthdayLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var coordinator: BirthdayCoordinator?
    var viewModel: BirthdayViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNameScreenLabel()
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
        currentBirthdayLabel.text = formater.string(from: datePicker.date)
        viewModel.setData(didSelectedDate: formater.string(from: datePicker.date))
    }
    
    func setupCurrentBirthdayLabel() {
        currentBirthdayLabel.text = viewModel?.selectedDate
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
        datePicker.maximumDate = NSCalendar.current.date(byAdding: .year, value: -3, to: Date())
        datePicker.date = viewModel.dateFromString ?? Date()
    }
    
}
