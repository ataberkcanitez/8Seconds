//
//  GamePlayViewController.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 22.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class GamePlayViewController: UIViewController {
    var ref: DatabaseReference!

    
    var gameRoom: GameRoom?{
        didSet{
            setupGame()
            waitForAnswers()
        }
    }
    
    var adminAnswer: String?{
        didSet{
            checkAnswers()
        }
    }
    var playerAnswer: String?{
           didSet{
               checkAnswers()
           }
       }
    private func checkAnswers(){
        print("Cevap kontrol ediliyor..")
        guard let gameRoom = gameRoom else { return }
        if gameRoom.adminAnswer == "-1" && gameRoom.playerAnswer == "-1"{
            return
        }
        if let adminAnswer = adminAnswer, let playerAnswer = playerAnswer{
            print("hem admin hem player cevabı var")
            print("admin : \(adminAnswer), player: \(playerAnswer)")
                //Ben adminsem
            gameRoom.adminAnswer = adminAnswer
            gameRoom.playerAnswer = playerAnswer
            let controller = WalkToWinViewControllerForTwo()
            controller.gameRoom = gameRoom
            let adminAnswerInt = Int(adminAnswer)
            let playerAnswerInt = Int(playerAnswer)
            
            
            controller.modalPresentationStyle = .overFullScreen
            self.present(controller, animated: true, completion: nil)
            
            
            

//                switch gameRoom.round {
//                case 0:
//                    guard let answer = Int(gameRoom.firstAnswer) else { return }
//                    print("answer : \(answer)")
//                    if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
//                        controller.winner = gameRoom.admin
//                    }else{
//                        controller.winner = gameRoom.player
//                    }
//
//                    controller.modalPresentationStyle = .overFullScreen
//                    self.present(controller, animated: true, completion: nil)
//
//                case 1:
//                    guard let answer = Int(gameRoom.secondAnswer) else { return }
//                    print("answer : \(answer)")
//
//                    if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
//                        controller.winner = gameRoom.admin
//                    }else{
//                        controller.winner = gameRoom.player
//                    }
//
//                    controller.modalPresentationStyle = .overFullScreen
//                    self.present(controller, animated: true, completion: nil)
//                case 2:
//                    guard let answer = Int(gameRoom.thirdAnswer) else { return }
//                    print("answer : \(answer)")
//
//
//                    if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
//                        controller.winner = gameRoom.admin
//                    }else{
//                        controller.winner = gameRoom.player
//                    }
//
//                    controller.modalPresentationStyle = .overFullScreen
//                    self.present(controller, animated: true, completion: nil)
//                case 3:
//                    guard let answer = Int(gameRoom.fourthAnswer) else { return }
//                    print("answer : \(answer)")
//
//
//                   if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
//                        controller.winner = gameRoom.admin
//                    }else{
//                        controller.winner = gameRoom.player
//                    }
//
//                    controller.modalPresentationStyle = .overFullScreen
//                    self.present(controller, animated: true, completion: nil)
//                case 4:
//                    guard let answer = Int(gameRoom.fifthAnswer) else { return }
//                    print("answer : \(answer)")
//
//
//                   if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
//                        controller.winner = gameRoom.admin
//                    }else{
//                        controller.winner = gameRoom.player
//                    }
//
//                    controller.modalPresentationStyle = .overFullScreen
//                    self.present(controller, animated: true, completion: nil)
//                default:
//                    print("hata")
//                }
            
            
                
        }
        
    }
    
    private func setupGame(){
        if let gameRoom = gameRoom{
            if gameRoom.admin == Auth.auth().currentUser?.uid{
                if gameRoom.player != "-1"{
                    
                    checkGameRoundAndSetQuestions()
                    runTimer()
                }else{
                    questionLabel.text = "Rakip Oyuncu Bekleniyor"
                    waitForPlayer()

                }
            }else{
                print("oyunu başlat")

                checkGameRoundAndSetQuestions()
                runTimer()
            }
            
            
        }
    }
    
    private func waitForPlayer(){
        if let gameRoom = gameRoom{
            ref = Database.database().reference()
            
            let currentRef = ref.child("gameRooms").child(gameRoom.roomId).observe(.childChanged) { (snapshot) in
                if snapshot.value as? String == "InGame"{
                    self.checkGameRoundAndSetQuestions()
                    self.runTimer()
                }
            }
        }
    }
    
    
    
    
    
    private func checkGameRoundAndSetQuestions(){
        if let gameRoom = gameRoom{
            
            switch gameRoom.round {
            case 0:
                questionLabel.text = gameRoom.firstQuestion
                question = gameRoom.firstQuestion
                
            case 1:
                questionLabel.text = gameRoom.secondQuestion
                question = gameRoom.secondQuestion
            case 2:
                questionLabel.text = gameRoom.thirdQuestion
                question = gameRoom.thirdQuestion
            case 3:
                questionLabel.text = gameRoom.fourthQuestion
                question = gameRoom.fourthQuestion
            case 4:
                questionLabel.text = gameRoom.fiftQhuestion
                question = gameRoom.fiftQhuestion
            default:
                questionLabel.text = "Bir Sorun Oluştu"
            }
            if let heightAnchor = questionHolderHeightAnchor{
                heightAnchor.constant = getQuestionHeight() + 40
            }else{
                setupViews()
            }
            
            
        }
    }
    
    
    var question: String = ""
    
    var second = 8
    var timer = Timer()
    let inComingMessageCellIdentifier: String = "inComingCellIdentifier"
    
    let myProfilePhotoView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "cartman")
        iv.layer.cornerRadius = 30
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 1
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 - 0"
        label.font = UIFont.systemFont(ofSize: 45, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    let clockIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "clockIcon"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let secondsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8"
        label.font = UIFont.init(name: "Bubblegum", size: 70)
        label.textColor = .black
        
        return label
    }()
    
    let questionHolderView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    let answersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.alwaysBounceVertical = true
        
        
        return cv
    }()
    
    lazy var answerTextField = UITextField()

    lazy var inputContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = #colorLiteral(red: 0.9097272158, green: 0.9098548293, blue: 0.9096869826, alpha: 1)
        
        let topSeperatorView = UIView()
        topSeperatorView.translatesAutoresizingMaskIntoConstraints = false
        topSeperatorView.backgroundColor = .black
        containerView.addSubview(topSeperatorView)
        NSLayoutConstraint.activate([
            topSeperatorView.bottomAnchor.constraint(equalTo: containerView.topAnchor),
            topSeperatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topSeperatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topSeperatorView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        let standartReactionsButton = UIButton(type: .system)
        standartReactionsButton.translatesAutoresizingMaskIntoConstraints = false
        standartReactionsButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        standartReactionsButton.setTitle("Standart Tepkiler", for: .normal)
        standartReactionsButton.titleLabel?.font = UIFont.systemFont(ofSize: 8, weight: .light)
        standartReactionsButton.titleLabel?.lineBreakMode = .byWordWrapping
        standartReactionsButton.titleLabel?.textAlignment = .center
        standartReactionsButton.layer.cornerRadius = 46/2
        standartReactionsButton.clipsToBounds = true
        standartReactionsButton.setTitleColor(.white, for: .normal)
        
        
        containerView.addSubview(standartReactionsButton)
        NSLayoutConstraint.activate([
            standartReactionsButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            standartReactionsButton.widthAnchor.constraint(equalToConstant: 46),
            standartReactionsButton.heightAnchor.constraint(equalToConstant: 46),
            standartReactionsButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15)
        ])
        
        let extraReactionsButton = UIButton(type: .system)
        extraReactionsButton.translatesAutoresizingMaskIntoConstraints = false
        extraReactionsButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        extraReactionsButton.setTitle("Standart Tepkiler", for: .normal)
        extraReactionsButton.titleLabel?.font = UIFont.systemFont(ofSize: 8, weight: .light)
        extraReactionsButton.titleLabel?.lineBreakMode = .byWordWrapping
        extraReactionsButton.titleLabel?.textAlignment = .center
        extraReactionsButton.layer.cornerRadius = 46/2
        extraReactionsButton.clipsToBounds = true
        extraReactionsButton.setTitleColor(.white, for: .normal)
        
        containerView.addSubview(extraReactionsButton)
        NSLayoutConstraint.activate([
            extraReactionsButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            extraReactionsButton.widthAnchor.constraint(equalToConstant: 46),
            extraReactionsButton.heightAnchor.constraint(equalToConstant: 46),
            extraReactionsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
        
        
        answerTextField.translatesAutoresizingMaskIntoConstraints = false
        answerTextField.backgroundColor = .white
        answerTextField.textColor = .black
        answerTextField.layer.cornerRadius = 5
        answerTextField.clipsToBounds = true
        answerTextField.layer.borderWidth = 1
        answerTextField.layer.borderColor = UIColor.black.cgColor
        answerTextField.keyboardType = .numberPad
        answerTextField.becomeFirstResponder()

        
        containerView.addSubview(answerTextField)
        NSLayoutConstraint.activate([
            answerTextField.leadingAnchor.constraint(equalTo: standartReactionsButton.trailingAnchor, constant: 15),
            answerTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 7),
            answerTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -7),
            answerTextField.trailingAnchor.constraint(equalTo: extraReactionsButton.leadingAnchor, constant: -15)
        ])
        
        answerTextField.setLeftPaddingPoints(10)
        
        
        
        let sendButton = UIButton(type: .system)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setImage(UIImage(named: "sendArrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        sendButton.imageView?.contentMode = .scaleAspectFit
        sendButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        sendButton.backgroundColor = #colorLiteral(red: 0.9097272158, green: 0.9098548293, blue: 0.9096869826, alpha: 1)
        sendButton.layer.cornerRadius = 5
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.layer.borderWidth = 1
        sendButton.clipsToBounds = true
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: answerTextField.topAnchor),
            sendButton.bottomAnchor.constraint(equalTo: answerTextField.bottomAnchor),
            sendButton.trailingAnchor.constraint(equalTo: answerTextField.trailingAnchor),
            sendButton.widthAnchor.constraint(equalTo: answerTextField.heightAnchor)
        ])
        return containerView
    }()
    
    //MARK:- Functions
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
    }
    
    private func setupViews(){
        view.backgroundColor = #colorLiteral(red: 0.9097272158, green: 0.9098548293, blue: 0.9096869826, alpha: 1)
        setupProfilePhoto()
        setupScoreLabel()
        setupSecondsLabel()
        setupClockIcon()
        setupQuestionHolder()
        setupQuestionLabel()
        setupAnswersCollectionView()
        setupInputContainerView()
        
        setupKeyboardNotificationObservers()
        

    }
    
    private func setupProfilePhoto(){
        view.addSubview(myProfilePhotoView)
        NSLayoutConstraint.activate([
            myProfilePhotoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            myProfilePhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            myProfilePhotoView.widthAnchor.constraint(equalToConstant: 60),
            myProfilePhotoView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func setupScoreLabel(){
        view.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: myProfilePhotoView.centerYAnchor)
        ])
    }
    private func setupSecondsLabel(){
        view.addSubview(secondsLabel)
        NSLayoutConstraint.activate([
            secondsLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            secondsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    private func setupClockIcon(){
        view.addSubview(clockIcon)
        NSLayoutConstraint.activate([
            clockIcon.trailingAnchor.constraint(equalTo: secondsLabel.leadingAnchor, constant: -15),
            clockIcon.heightAnchor.constraint(equalToConstant: 35),
            clockIcon.widthAnchor.constraint(equalToConstant: 30),
            clockIcon.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor)
        ])
    }
    var questionHolderHeightAnchor: NSLayoutConstraint?

    private func setupQuestionHolder(){
        view.addSubview(questionHolderView)
        view.layoutIfNeeded()
        let questionWidth = view.frame.width - 50
        let requiredHeight = getEstimatedHeightOfString(string: question, stringWidth: Int(questionWidth), stringFont: UIFont.systemFont(ofSize: 22, weight: .regular))
        questionHolderHeightAnchor = questionHolderView.heightAnchor.constraint(equalToConstant: requiredHeight + 40)
        guard let heightAnchor = questionHolderHeightAnchor else { return }
        NSLayoutConstraint.activate([
            questionHolderView.topAnchor.constraint(equalTo: myProfilePhotoView.bottomAnchor, constant: 10),
            questionHolderView.leadingAnchor.constraint(equalTo: myProfilePhotoView.leadingAnchor),
            questionHolderView.trailingAnchor.constraint(equalTo: secondsLabel.trailingAnchor),
            heightAnchor
        ])
    }
    
    private func setupQuestionLabel(){
        questionHolderView.addSubview(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: questionHolderView.topAnchor, constant: 10),
            questionLabel.leadingAnchor.constraint(equalTo: questionHolderView.leadingAnchor, constant: 10),
            questionLabel.trailingAnchor.constraint(equalTo: questionHolderView.trailingAnchor, constant: -10),
            questionLabel.bottomAnchor.constraint(equalTo: questionHolderView.bottomAnchor, constant: -10)
        ])
    }
    
    
    private func setupAnswersCollectionView(){
        view.addSubview(answersCollectionView)
              
        NSLayoutConstraint.activate([
            answersCollectionView.topAnchor.constraint(equalTo: questionHolderView.bottomAnchor, constant: 15),
            answersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            answersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            answersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
        registerCellsToCV()
    }
    
    
    var inputContainerViewBottomAnchor: NSLayoutConstraint!
    private func setupInputContainerView(){
        view.addSubview(inputContainerView)
        
        inputContainerViewBottomAnchor = inputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            inputContainerViewBottomAnchor,
            inputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputContainerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupKeyboardNotificationObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    @objc private func keyboardWillShow(notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            inputContainerViewBottomAnchor.constant = -keyboardSize.height
        }        
    }
    
    @objc private func keyboardWillHide(){
        inputContainerViewBottomAnchor.constant = 0
        
    }
    
    private func getQuestionHeight() -> CGFloat{
        view.layoutIfNeeded()
        let questionWidth = view.frame.width - 50
        let requiredHeight = getEstimatedHeightOfString(string: question, stringWidth: Int(questionWidth), stringFont: UIFont.systemFont(ofSize: 22, weight: .regular))
        return requiredHeight
    }
    
    private func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        
        second -= 1
        if second >= 0 {
            secondsLabel.text = "\(second)"
        }
        if secondsLabel.text == "0"{
            self.makeAlert(alertMessage: "Kaybettin")
            timer.invalidate()
            return
            
        }
    }
    
    
    //MARK:- handlers
    @objc private func handleSend(){
        let labelInt = Int(secondsLabel.text!)
        guard let leftTime = labelInt else { return }
        print(leftTime)
        if(leftTime >= 0){
            print("saniye sınırı üstünde")
            ref = Database.database().reference()
            if let gameRoom = gameRoom{
                if gameRoom.admin == Auth.auth().currentUser?.uid{
                    if answerTextField.text != "" {
                        saveAdminAnswer(roomId: gameRoom.roomId, answer: answerTextField.text!)
                    }
                }else{
                    if answerTextField.text != ""{
                        savePlayerAnswer(roomId: gameRoom.roomId, answer: answerTextField.text!)
                    }
                }
            }
        }else{
            print("kaybettin")
        }
        
        
    }
    private func saveAdminAnswer(roomId: String, answer: String){
        self.timer.invalidate()

        self.ref.child("gameRooms").child(roomId).updateChildValues(["adminAnswer": answer]) { (error, ref) in
            if let error = error{
                self.makeAlert(alertMessage: "Hata oldu.")
            }
            self.answerTextField.text = ""
        }
    }
    
    private func savePlayerAnswer(roomId: String, answer: String){
        self.timer.invalidate()

        self.ref.child("gameRooms").child(roomId).updateChildValues(["playerAnswer": answer]) { (error, ref) in
            if let error = error{
                self.makeAlert(alertMessage: "Hata oldu.")
            }
            self.answerTextField.text = ""
        }
    }
    
    
    
    private func makeAlert(alertMessage: String){
        let alert = UIAlertController(title: "Uyarı", message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    private func waitForAnswers(){
        guard let gameRoom = gameRoom else { return }
        ref = Database.database().reference()
        let answersRef = ref.child("gameRooms").child(gameRoom.roomId)
        answersRef.observe(.childChanged) { (snapshot) in
            print("cevap eklendi")
            
            print("key : \(snapshot.key)")
            
            if snapshot.key as? String == "adminAnswer"{
                self.adminAnswer = snapshot.value as? String
            }else if snapshot.key as? String == "playerAnswer"{
                self.playerAnswer = snapshot.value as? String
            }
            
            
            if snapshot.value as? String == "InGame"{
                self.checkGameRoundAndSetQuestions()
                self.runTimer()
            }
        }
    }
    

}




//MARK:- Collectionview delegates:
extension GamePlayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func registerCellsToCV(){
        answersCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        answersCollectionView.register(GamePlayIncomingMessageCell.self, forCellWithReuseIdentifier: inComingMessageCellIdentifier)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let incomingCell = collectionView.dequeueReusableCell(withReuseIdentifier: inComingMessageCellIdentifier, for: indexPath) as! GamePlayIncomingMessageCell
        
        return incomingCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
