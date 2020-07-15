//
//  RegisterViewController.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 16.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    var sex: String = "Male"
    
    let cities: [String] = ["Adana", "Adıyaman", "Afyon", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta", "İçel (Mersin)", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "K.maraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce" ]
    
    
    let cityPicker: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .white
        
        return pickerView
    }()
    
    let datePicker: UIDatePicker = {
        let pickerView = UIDatePicker(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .white
        
        return pickerView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ad Soyad"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 3
        tf.clipsToBounds = true
        return tf
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Şehir"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    let cityView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    let selectedCityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var dropDownListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("↓", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(cityHandler), for: .touchUpInside)
        button.layer.cornerRadius = 3
        
        
        return button
    }()
    
    
    let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Doğum Tarihi"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    let dateView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    let selectedDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    
    
    
    let sexLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cinsiyet seç"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var maleButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitle("E", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(maleSelector), for: .touchUpInside)
        
        return button
    }()
    
    lazy var femaleButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("K", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(femaleSelector), for: .touchUpInside)
        
        return button
    }()
    
    
    let mailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-posta Adresi"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    let mailTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 3
        tf.clipsToBounds = true
        return tf
    }()
    
    
    let passwordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Şifre"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.backgroundColor = .white
        tf.isSecureTextEntry = true
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 3
        tf.clipsToBounds = true
        tf.delegate = self
        return tf
    }()
    
    let secondPasswordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tekrar Şifre"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var secondPasswordTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 5
        tf.isSecureTextEntry = true
        tf.clipsToBounds = true
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 3
        tf.clipsToBounds = true
        tf.delegate = self
        return tf
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.setTitle("Kayıt Ol", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(registerHandler), for: .touchUpInside)
        
        
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = #colorLiteral(red: 0.8416554928, green: 0.8417771459, blue: 0.8416288495, alpha: 1)
        setupNameFields()
        setupCity()
        setupSex()
        setupBirthday()
        setupMail()
        setupPassword()
        setupSecondPassword()
        setupRegisterButton()
        
        setupPaddings()
        
        //en son:
        setupPickerView()
    }
    

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
   
    
    private func setupNameFields(){
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupCity(){
        view.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor)
        ])
        view.layoutIfNeeded()
        view.addSubview(cityView)
        nameTextField.layoutIfNeeded()
        let nameTextFieldWidth = nameTextField.frame.width
        let height = nameTextField.frame.height
        
        
        
        NSLayoutConstraint.activate([
            cityView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            cityView.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            cityView.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            cityView.widthAnchor.constraint(equalToConstant: nameTextFieldWidth - (2 * height) - 20)
        ])
        
        
        cityView.addSubview(dropDownListButton)
        NSLayoutConstraint.activate([
            dropDownListButton.trailingAnchor.constraint(equalTo: cityView.trailingAnchor),
            dropDownListButton.centerYAnchor.constraint(equalTo: cityView.centerYAnchor),
            dropDownListButton.heightAnchor.constraint(equalTo: cityView.heightAnchor),
            dropDownListButton.widthAnchor.constraint(equalTo: cityView.heightAnchor)
        ])
        
        cityView.addSubview(selectedCityLabel)
        NSLayoutConstraint.activate([
            selectedCityLabel.centerYAnchor.constraint(equalTo: cityView.centerYAnchor),
            selectedCityLabel.leadingAnchor.constraint(equalTo: cityView.leadingAnchor, constant: 5)
        ])
        
    }
    
    private func setupSex(){
        view.addSubview(sexLabel)
        NSLayoutConstraint.activate([
            sexLabel.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
            sexLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45)
        
        ])
        
        
        view.addSubview(femaleButton)
        NSLayoutConstraint.activate([
            femaleButton.heightAnchor.constraint(equalTo: cityView.heightAnchor),
            femaleButton.leadingAnchor.constraint(equalTo: cityView.trailingAnchor, constant: 10),
            femaleButton.widthAnchor.constraint(equalTo: cityView.heightAnchor),
            femaleButton.centerYAnchor.constraint(equalTo: cityView.centerYAnchor)
        ])
        
        
        view.addSubview(maleButton)
        NSLayoutConstraint.activate([
            maleButton.heightAnchor.constraint(equalTo: cityView.heightAnchor),
            maleButton.leadingAnchor.constraint(equalTo: femaleButton.trailingAnchor, constant: 10),
            maleButton.widthAnchor.constraint(equalTo: cityView.heightAnchor),
            maleButton.centerYAnchor.constraint(equalTo: cityView.centerYAnchor)
        ])
    }
    
    private func setupBirthday(){
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: cityView.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor)
        ])
        view.addSubview(dateView)
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            dateView.leadingAnchor.constraint(equalTo: cityView.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            dateView.heightAnchor.constraint(equalTo: cityView.heightAnchor)
        ])
        dateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDatePickerHidden)))
        view.addSubview(selectedDateLabel)
        NSLayoutConstraint.activate([
            selectedDateLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
            selectedDateLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 10)
        ])
        
        
    }
    
    private func setupMail(){
        view.addSubview(mailLabel)
        NSLayoutConstraint.activate([
            mailLabel.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 10),
            mailLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor)
        ])
        
        view.addSubview(mailTextField)
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: mailLabel.bottomAnchor, constant: 5),
            mailTextField.leadingAnchor.constraint(equalTo: dateView.leadingAnchor),
            mailTextField.trailingAnchor.constraint(equalTo: dateView.trailingAnchor),
            mailTextField.heightAnchor.constraint(equalTo: dateView.heightAnchor)            
        ])
        
    }
    
    private func setupPassword(){
        view.addSubview(passwordLabel)
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 10),
            passwordLabel.leadingAnchor.constraint(equalTo: mailLabel.leadingAnchor)
        ])
        
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: mailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: mailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: mailTextField.heightAnchor)
        ])
        
    }
    
    private func setupSecondPassword(){
        view.addSubview(secondPasswordLabel)
        
        NSLayoutConstraint.activate([
            secondPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            secondPasswordLabel.leadingAnchor.constraint(equalTo: mailLabel.leadingAnchor)
        ])
        
        view.addSubview(secondPasswordTextField)
        NSLayoutConstraint.activate([
            secondPasswordTextField.topAnchor.constraint(equalTo: secondPasswordLabel.bottomAnchor, constant: 5),
            secondPasswordTextField.leadingAnchor.constraint(equalTo: mailTextField.leadingAnchor),
            secondPasswordTextField.trailingAnchor.constraint(equalTo: mailTextField.trailingAnchor),
            secondPasswordTextField.heightAnchor.constraint(equalTo: mailTextField.heightAnchor)
        ])
    }
    
    private func setupRegisterButton(){
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            registerButton.trailingAnchor.constraint(equalTo: secondPasswordTextField.trailingAnchor),
            registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func setupPickerView(){
        view.addSubview(cityPicker)
        NSLayoutConstraint.activate([
            cityPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cityPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityPicker.heightAnchor.constraint(equalToConstant: 250)
        ])
        cityPicker.isHidden = true
        cityPicker.delegate = self
        cityPicker.dataSource = self
        
        
        view.addSubview(datePicker)
        datePicker.datePickerMode = .date
        NSLayoutConstraint.activate([
            datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 250)
        ])
        datePicker.isHidden = true
        
        datePicker.addTarget(self, action: #selector(handleDatePicker(picker:)), for: .valueChanged)
    }

    
    private func setupPaddings(){
        [secondPasswordTextField, passwordTextField, nameTextField, mailTextField].forEach { (textField) in
            textField.setLeftPaddingPoints(10)
        }
    }
    
    //MARK:- handlers:
    @objc func cityHandler(){
        view.endEditing(true)
        datePicker.isHidden = true
        cityPicker.isHidden = !cityPicker.isHidden
    }
    @objc func handleDatePickerHidden(){
        view.endEditing(true)
        datePicker.isHidden = false
    }
    
    @objc func handleDatePicker( picker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        selectedDateLabel.text = formatter.string(from: datePicker.date)
    }
    
    //handle touches:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        cityPicker.isHidden = true
        datePicker.isHidden = true
    }
    
    @objc func maleSelector(){
        sex = "Erkek"
        femaleButton.backgroundColor = .white
        maleButton.backgroundColor = .green
    }
    @objc func femaleSelector(){
        sex = "Kadın"
        femaleButton.backgroundColor = .green
        maleButton.backgroundColor = .white
    }
    
    var user: UserToRegister?
    
    @objc func registerHandler(){
        print(selectedCityLabel)
        if checkForEmptyInputs() {
            user = UserToRegister(fullname: nameTextField.text!, city: selectedCityLabel.text!, sex: sex, birthday: selectedDateLabel.text!, email: mailTextField.text!, password: passwordTextField.text!)
            
            Auth.auth().createUser(withEmail: mailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
                if error != nil{
                    self.makeAlert(alertMessage: "Bir hata oluştu. Lütfen daha sonra tekrar deneyin.")
                }
                if let uid = authResult?.user.uid{
                    self.saveUserToRealtimeDatabase(uid: uid)
                }
            }
        }
        
        
    }
    
    private func saveUserToRealtimeDatabase(uid: String){
        
        ref = Database.database().reference()
        let userDictionary: [String: Any] = ["id": uid,"name": user!.fullName, "city": user!.city, "sex": user!.sex,"birthday": user!.birthday,"email": user!.email]
        ref.child("users").child(uid).setValue(userDictionary){
            (error: Error?, ref:DatabaseReference) in
            if error != nil{
                self.makeAlert(alertMessage: "Bir hata oluştu. lütfen tekrar deneyin")
            }else{
                let loginController = LoginController()
                loginController.modalPresentationStyle = .overFullScreen

                loginController.mailTextField.text = self.user!.email
                loginController.passwordTextField.text = self.user!.password
                self.present(loginController, animated: true, completion: nil)
            }
        }
        
    }
    
    
    private  func checkForEmptyInputs() -> Bool{
        if(nameTextField.text == "" || selectedCityLabel.text == "" || selectedDateLabel.text == "" || mailTextField.text == "" || passwordTextField.text == "" || secondPasswordTextField.text == "" ){
            makeAlert(alertMessage: "Boş alan bırakamazsınız")
            return false
        }
        
        if(passwordTextField.text != secondPasswordTextField.text){
            makeAlert(alertMessage: "Girdiğiniz şifreler birbiri ile uyuşmuyor")
            return false
        }
        
        return true
    }
    
    
    
    private func makeAlert(alertMessage: String){
        let alert = UIAlertController(title: "Uyarı", message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}

extension RegisterViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        NotificationCenter.default.removeObserver(self)
    }
    
}





//MARK:- PickerView Delegates
extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cities.count
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCityLabel.text = cities[row]
    }
    
    
}
