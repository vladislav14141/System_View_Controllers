//
//  TableViewController.swift
//  System_View_Controllers
//
//  Created by Миронов Влад on 20/04/2019.
//  Copyright © 2019 Миронов Влад. All rights reserved.
//

import UIKit

class RegisterController: UITableViewController {

    
    // MARK: - @IBOutlet
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var checkInLabel: UILabel!
    @IBOutlet var checkOutLabel: UILabel!
    @IBOutlet var checkInPicker: UIDatePicker!
    @IBOutlet var checkOutPicker: UIDatePicker!
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    @IBOutlet var selectedRoomLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var wifiPriceLabel: UILabel!
    @IBOutlet var wifiSwitch: UISwitch!
    @IBOutlet var fullPrice: UILabel!
    // MARK: - Properties
    let checkInDatePicker = IndexPath(row: 1, section: 1)
    let checkOutDatePicker = IndexPath(row: 3, section: 1)
    
    var takedRoom: RoomType? {
        didSet {
            let wifiSum = wifiSwitch.isOn ? 5 * beetwenDaysCount : 0
            let adultPriceSum = takedRoom!.price * beetwenDaysCount * Int(numberOfAdultsStepper.value)
            let childrenPriceSum = Int(Double(takedRoom!.price) * 0.5) * beetwenDaysCount * Int(numberOfChildrenStepper.value)
            fullPrice.text = "\(wifiSum + adultPriceSum + childrenPriceSum)$"
        }
    }
    var beetwenDaysCount = 1
    var isCheckInDatePickerShown = false {
        didSet {
            checkInPicker.isHidden = !isCheckInDatePickerShown
            
        }
    }
    var isCheckOutDatePickerShown = false {
        didSet {
            checkOutPicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    

    @IBAction func acceptOrderButtonClick(_ sender: UIButton) {
        let validate = checkValidation(testStr: firstNameField.text!) && checkValidation(testStr: lastNameField.text!) && checkMailValidation(email: emailField.text!)
        if validate {
            print(
                """
                Имя:\(firstNameField.text ?? "")
                Фамилия:\(lastNameField.text ?? "")
                Почта:\(emailField.text ?? "")
                Вьезд:\(checkInLabel.text ?? "")
                Выезд:\(checkOutLabel.text ?? "")
                Количество взрослых:\(numberOfAdultsLabel.text ?? "")
                Количество детей:\(numberOfChildrenLabel.text ?? "")
                Выбранная комната:\(selectedRoomLabel.text ?? "")
                \(wifiPriceLabel.text ?? "")
                \(fullPrice.text ?? "")
                """)
            sender.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)

        } else {
            sender.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        
    }
    
    @IBAction func stepperChangedValue() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
        updatePrice()
    }
    
    @IBAction func datePickerChanged() {
        updateDateViews()
    }
    
    

    
}

// MARK: - SupportFunc
extension RegisterController {
    func setupDateViews(){
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInPicker.minimumDate = midnightToday
        checkInPicker.date = midnightToday
    }
    
    func setupUI() {
        setupDateViews()
    }
    
    func updateDateViews() {
        checkOutPicker.minimumDate = checkInPicker.date.addingTimeInterval(60 * 60 * 24)
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        checkInLabel.text = formatter.string(from: checkInPicker.date)
        checkOutLabel.text = formatter.string(from: checkOutPicker.date)
        
        let beetwenDaysCalendar = Calendar.current.dateComponents([.day,], from: checkInPicker.date, to: checkOutPicker.date)
        beetwenDaysCount = beetwenDaysCalendar.day!
        wifiPriceLabel.text = "WiFi - \(5 * beetwenDaysCount)$"
        updatePrice()
       
    }
    func updatePrice() {
        
        let wifiSum = wifiSwitch.isOn ? 5 * beetwenDaysCount : 0
        guard let price = takedRoom?.price else {
            fullPrice.text = "\(wifiSum)$"
            return
        }
        let adultPriceSum = price * beetwenDaysCount * Int(numberOfAdultsStepper.value)
        let childrenPriceSum = Int(Double(price) * 0.5) * beetwenDaysCount * Int(numberOfChildrenStepper.value)
        fullPrice.text = "\(wifiSum + adultPriceSum + childrenPriceSum)$"
    }
    
    func updateUI() {
        updateDateViews()
    }
    
    // MARK: - Validation
    func checkValidation(testStr:String) -> Bool {
        guard testStr.count > 2, testStr.count < 18 else { return false }
        
        return true
    }
    
    func checkMailValidation(email: String) -> Bool{
        let emails = ["@mail.ru","@yandex.ru", "@gmail.com", "@outlook.com", "@icloud.com"]
        var returned = false
        emails.forEach {
            if email.contains($0) {
                returned = true
            }
        }
        return returned
    }
}


// MARK: - TableViewControllerDataSource
extension RegisterController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let autoHeight = UITableView.automaticDimension
        
        switch indexPath {
        case checkInDatePicker:
            return isCheckInDatePickerShown ? autoHeight : 0
        case checkOutDatePicker:
            return isCheckOutDatePickerShown ? autoHeight : 0
        default:
            return autoHeight
        }
    }
}

// MARK: - TableViewControllerDelegate
extension RegisterController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case checkInDatePicker.prevRow:
            isCheckInDatePickerShown.toggle()
            
            isCheckOutDatePickerShown = isCheckInDatePickerShown ? false : isCheckOutDatePickerShown
        case checkOutDatePicker.prevRow:
            isCheckOutDatePickerShown.toggle()
            
            isCheckInDatePickerShown = isCheckOutDatePickerShown ? false : isCheckInDatePickerShown

        default:
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func myUnwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveRoom" else { return }
        guard let controller = segue.source as? takeRoomTableViewController else { return }
        guard let room = controller.takedRoom else {return}
        takedRoom = room
        selectedRoomLabel.text = room.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "takeRoom" else {return}
        let dvc = segue.destination as! takeRoomTableViewController
        dvc.takedRoom = takedRoom
    }
    
}

