//
//  AddRegistrationTableViewController.swift
//  HotelCalifornia
//
//  Created by Furkan Bingöl on 2.03.2023.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {

    // MARK: - UI Elements
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    
    // MARK: - Properties
    let oneDay: Double = 24 * 60 * 60   //sn
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    
    var isCheckInDatePickerShown: Bool = false {     //computed property
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerShown: Bool = false {    //computed property
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var roomType: RoomType?   // Diğer sayfada seçilen roomType'ı, bu roomType'a atayacağız.
    
    var registration: Registration? {     // get-only
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn

        return Registration(firstName: firstName, lastName: lastName, emailAddress: email,
                            checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults,
                            numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi)
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // checkIn tarihini, bugün olarak ayarlar.
        let today = Calendar.current.startOfDay(for: Date())    // Date() -> O an'ın tarihini verir. (Saat bilgisi dahil)
        
        checkInDatePicker.minimumDate = today      // seçilebilecek en küçük tarihi ayarlar.
        checkInDatePicker.date = today             // seçili olan tarihi ayarlar.
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
    }
    
    
    // MARK: - Functions
    
    func updateDateViews() {
        // 21/03/1996 -> .short  -> 3:30 PM
        // 21/03/1996 -> .medium -> March 21, 1996
        // DateFormatter(class) ve DateStyle(enum --> .short, .medium, .long, .full) kullanıyoruz.
        
        // Otelde minimum 1 gün konaklama yapılacağı için;
        // checkOutDatePicker'in minimumDate'i, o an seçili olan checkIn tarihinden 24 saat sonrası olarak ayarlanmalıdır.
        // addingTimeInterval: Var olan bir Date nesnesinin üzerine, belirtilen miktarda saniye ekler.
        
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(oneDay)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)      // DatePicker'lardaki değişiklikleri, label'a yansıttık.
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)    // DatePicker'lardaki değişiklikleri, label'a yansıttık.
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    func updateRoomType() {
        if let roomType = roomType {    // roomType seçildiyse
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    
    // protocol stub
    func didSelect(roomType: RoomType) {    // Diğer VC'de bu fonksiyon çalıştırıldığında, aslında bu VC'deki fonksiyon çalıştırılacak. --> "Delegate Design Pattern"
        self.roomType = roomType
        updateRoomType()
    }
    
    
    // Diğer segue'ye geçilmeden önce yapılacaklar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectRoomType" {
            let destVC = segue.destination as! SelectRoomTypeTableViewController
            destVC.delegate = self    // Bu sayede, diğer VC'de didSelectRow yaptığımızda; çalışacak delegate'in didSelect() fonksiyonu, BU VC'deki didSelect() olacak.
            destVC.selectedRoomType = roomType
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown {       //CheckInDatePicker ekranda gözüküyorsa
                return 216
            } else {
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown {      //CheckOutDatePicker ekranda gözüküyorsa
                return 216
            } else {
                return 0
            }
        default:
            return 50    // Picker hücreleri dışında kalan tüm hücrelerin yüksekliği
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Seçili olan hücrenin, seçili olma durumunu sonlandırır. (GRİLİĞİ Kaldırır)
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case checkInDateLabelCellIndexPath:
            if isCheckInDatePickerShown {            //görünüyorsa ve didSelectRowAt çalıştıysa
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {    //görünüyorsa ve didSelectRowAt çalıştıysa
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {                                 //görünmüyosa ve didSelectRowAt çalıştıysa
                isCheckInDatePickerShown = true
            }
            
        case checkOutDateLabelCellIndexPath:
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            
        default:
            break
        }
        
        // Değişkenlerdeki değişim ile, heightForRow fonksiyonu tekrar çalıştırılır.
        // Fakat yükseklik değişimlerini ANİMASYON ile sağlamak istersek alttaki yöntemi kullanabiliriz.
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    
    // MARK: - Actions
    
    
    // Tek bir @IBAction'a birden fazla UI-Element bağlayabiliriz.
    @IBAction func datePickerValueChanged(_ picker: UIDatePicker) {
        updateDateViews()
    }
    
    // Tek bir @IBAction'a birden fazla UI-Element bağlayabiliriz.
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        
    }
    
    
    @IBAction func cancelBarButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)    // dismiss(): bir önceki VC'ye geri dön
    }
}
