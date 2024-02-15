//
//  DatePickerViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import UIKit

final class DatePickerViewController: BaseViewController {
    typealias Action = (Date) -> Void
    
    var action: Action?
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.addTarget(self, action: #selector(actionForDatePicker), for: .valueChanged)
        return picker
    }()
    
    init(mode: UIDatePicker.Mode, pickerStyle: UIDatePickerStyle = .wheels, minDate: Date? = nil, maxDate: Date? = nil, action: Action?) {
        super.init()
        datePicker.datePickerMode = mode
        datePicker.date = minDate ?? Date()
        datePicker.locale = UserSettings().appLanguage.locale
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        datePicker.tintColor = .systemBlue
        datePicker.preferredDatePickerStyle = pickerStyle
        self.action = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = datePicker
    }
    
    @objc private func actionForDatePicker() {
        action?(datePicker.date)
    }
    
    func setDate(_ date: Date) {
        datePicker.setDate(date, animated: true)
    }
}
