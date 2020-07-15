//
//  ViewController.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 11.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



var currentUser: User?

class LoginController: UIViewController {
    
    var ref: DatabaseReference!

    let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "launchLogo"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    let mailTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.placeholder = "E-posta adresi"
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.placeholder = "Şifre"
        
        return tf
    }()
    
    lazy var guestButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Misafir olarak gir", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleQuestLogin), for: .touchUpInside)
        
        
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Giriş yap", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.6892687678, green: 0, blue: 0, alpha: 1)
        button.setTitle("KAYIT OL", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action:#selector(handleToRegister) , for: .touchUpInside)
        
        return button
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupUserDefaults()
        
    }
    
    private func setupUserDefaults(){
        mailTextField.text = UserDefaults.standard.string(forKey: "userEmail")
        passwordTextField.text = UserDefaults.standard.string(forKey: "pass")
    }
    
    
    private func setupViews(){
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupNavigationBar()
        setupLogo()
        setupMailTextField()
        setupPasswordTextField()
        setupGuestButton()
        setupLoginButton()
        setupRegisterButton()
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    private func setupLogo(){
        view.addSubview(logoImageView)
        
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        let imageWidth = viewWidth * 1/4
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            logoImageView.heightAnchor.constraint(equalToConstant: (viewHeight * imageWidth) / viewWidth)
        ])
    }
    
    
    private func setupMailTextField(){
        view.addSubview(mailTextField)
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            mailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        mailTextField.setLeftPaddingPoints(10)
    }
    
    private func setupPasswordTextField(){
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        passwordTextField.setLeftPaddingPoints(10)
    }
    
    private func setupGuestButton(){
        view.addSubview(guestButton)
        passwordTextField.layoutIfNeeded()
        let textfieldWidth = passwordTextField.frame.width
        let totalParts = textfieldWidth / 18
        
        let buttonWidth = (textfieldWidth - totalParts) * 3/5
        
        NSLayoutConstraint.activate([
            guestButton.heightAnchor.constraint(equalToConstant: 50),
            guestButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            guestButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            guestButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])
        
    }
    
    
    private func setupLoginButton(){
        view.addSubview(loginButton)
        passwordTextField.layoutIfNeeded()
        let textfieldWidth = passwordTextField.frame.width
        let totalParts = textfieldWidth / 18
        
        let buttonWidth = (textfieldWidth - totalParts) * 2/5
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            loginButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])
    }
    
    
    private func setupRegisterButton(){
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: (view.frame.width * 0.65)),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    
    
    //MARK:- Handlers
    
    @objc func handleQuestLogin(){
        makeAlert(alertMessage: "Misafir Girişi Çok yakında")
    }
    
    @objc func handleToRegister(){
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc func handleLogin(){
        self.view.endEditing(true)
        
        if checkForEmptyInputs() {
            Auth.auth().signIn(withEmail: mailTextField.text!.lowercased(), password: passwordTextField.text!) { (result, error) in
                if let error = error{
                    self.makeAlert(alertMessage: error.localizedDescription)
                    return
                }else{
                    
                    self.getUserData(userPass: self.passwordTextField.text!)

                    
                }
            }
        }
    }
    
    private func getUserData(userPass: String){
        ref = Database.database().reference()

        let userId = Auth.auth().currentUser!.uid
        
        Vibration.success.vibrate()
        
        ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let birthday = value?["birthday"] as? String ?? ""
            let city = value?["city"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            let sex = value?["sex"] as? String ?? ""
            let profilePhoto = value?["profilePhoto"] as? String ?? ""
            let totalPoint = value?["totalPoint"] as? Int ?? -1
            
            
            let user = User(uid: userId, fullname: name, city: city, sex: sex, birthday: birthday, email: email, profilePhoto: profilePhoto, totalPoint: totalPoint)
            
            currentUser = user
            
            UserDefaults.standard.set(email, forKey: "userEmail")
            UserDefaults.standard.set(userPass, forKey: "pass")
            
            let dashboardViewController = DashboardViewController()
            dashboardViewController.modalPresentationStyle = .fullScreen
            self.present(dashboardViewController, animated: true, completion: nil)
            
        }
        
    }
    
    
    private func checkForEmptyInputs() -> Bool{
        if mailTextField.text == "" || passwordTextField.text == "" {
            makeAlert(alertMessage: "Boş alan bırakamazsınız")
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






extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
