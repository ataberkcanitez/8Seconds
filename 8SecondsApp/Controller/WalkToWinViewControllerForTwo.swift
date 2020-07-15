//
//  WalkToWinViewController.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 15.06.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class WalkToWinViewControllerForTwo: UIViewController {
    
    var ref: DatabaseReference!

    var gameRoom: GameRoom?{
        didSet{
            setQuestionLabel()
            ref = Database.database().reference()
            let usersRef = ref.child("users")
           let isAdminWinner = checkForWinner()
            if isAdminWinner{
                usersRef.child(gameRoom!.admin).observeSingleEvent(of: .value) { (snapshot) in
                    if snapshot.childrenCount > 0{
                        for child in snapshot.children{
                            let snap = child as! DataSnapshot
                            if let dictionary = snap.value as? [String : Any]{
                                self.myProfilePhoto.loadImageUsingUrlString(urlString: dictionary["profilePhoto"] as! String)
                            }
                        }
                    }
                }
                
                usersRef.child(gameRoom!.player).observeSingleEvent(of: .value) { (snapshot) in
                    if snapshot.childrenCount > 0{
                        for child in snapshot.children{
                            let snap = child as! DataSnapshot
                            if let dictionary = snap.value as? [String: Any]{
                                self.opponentProfilePhoto.loadImageUsingUrlString(urlString: dictionary["profilePhoto"] as! String)
                            }
                        }
                    }
                }
            }else{
                usersRef.child(gameRoom!.admin).observeSingleEvent(of: .value) { (snapshot) in
                    if snapshot.childrenCount > 0{
                        for child in snapshot.children{
                            let snap = child as! DataSnapshot
                            if let dictionary = snap.value as? [String : Any]{
                                self.opponentProfilePhoto.loadImageUsingUrlString(urlString: dictionary["profilePhoto"] as! String)
                            }
                        }
                    }
                }
                
                usersRef.child(gameRoom!.player).observeSingleEvent(of: .value) { (snapshot) in
                    if snapshot.childrenCount > 0{
                        for child in snapshot.children{
                            let snap = child as! DataSnapshot
                            if let dictionary = snap.value as? [String: Any]{
                                self.myProfilePhoto.loadImageUsingUrlString(urlString: dictionary["profilePhoto"] as! String)
                            }
                        }
                    }
                }
            }
            if let anchor = opponentTrailingConstraint{
                print("handle Animation")
                handleAnimation()
            }else{
                print("viewdidload")
                viewDidLoad()
                handleAnimation()
            }
            
        }
    }
    
    func setQuestionLabel(){
        switch gameRoom!.round {
        case 1:
            questionLabel.text = gameRoom!.firstQuestion
         case 2:
                   questionLabel.text = gameRoom!.secondQuestion
            case 3:
                       questionLabel.text = gameRoom!.thirdQuestion
            case 4:
                       questionLabel.text = gameRoom!.fourthQuestion
            case 5:
                       questionLabel.text = gameRoom!.fiftQhuestion
        default:
            print("hata")
        }
    }
    
    var winner: String?{
        didSet{
            //handleAnimation()
        }
    }
    
    public func checkForWinner() -> Bool{ // adminse True
        let adminAnswer = gameRoom!.adminAnswer
        let (playerAnswer) = gameRoom!.playerAnswer
        let adminAnswerInt = Int(adminAnswer)
        let playerAnswerInt = Int(playerAnswer)
        

            switch gameRoom!.round {
            case 0:
                if let answer = Int(gameRoom!.firstAnswer){
                    if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
                        return true
                        //controller.winner = gameRoom.admin
                    }else{
                        return false
                        //controller.winner = gameRoom.player
                    }
                }
            case 1:
                if let answer = Int(gameRoom!.secondAnswer){
                    if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
                        return true
                        //controller.winner = gameRoom.admin
                    }else{
                        return false
                        //controller.winner = gameRoom.player
                    }
                }
            case 2:
                if let answer = Int(gameRoom!.thirdAnswer){
                    if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
                        return true
                        //controller.winner = gameRoom.admin
                    }else{
                        return false
                        //controller.winner = gameRoom.player
                    }
                }
            case 3:
                if let answer = Int(gameRoom!.fourthAnswer){
                    if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
                        return true
                        //controller.winner = gameRoom.admin
                    }else{
                        return false
                        //controller.winner = gameRoom.player
                    }
                }
            case 4:
                if let answer = Int(gameRoom!.fifthAnswer){
                    if abs(adminAnswerInt! - answer) < abs(playerAnswerInt! - answer){
                        return true
                        //controller.winner = gameRoom.admin
                    }else{
                        return false
                        //controller.winner = gameRoom.player
                    }
                }
            default:
                return false
                print("hata")
            }
        return false
    }
    
    let profilePhotoSize:CGFloat = 90
    let strokeTextAttributes: [NSAttributedString.Key: Any] = [.strokeColor: UIColor.black, .foregroundColor : UIColor.white, .strokeWidth : -2.0]
    
    var count: Int = 0
    let borderLayer = CAShapeLayer()
    let myDashedLayer = CAShapeLayer()
    let  myPath = UIBezierPath()
    
    let questionHolderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        
        return view
    }()
    let questionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
                
        return label
    }()
    
    let questionMarkHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 55
        view.clipsToBounds = true
        return view
    }()
    
    lazy var myProfilePhoto: RemoteImages = {
        let imageView = RemoteImages()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = profilePhotoSize/2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var opponentProfilePhoto: RemoteImages = {
        let imageView = RemoteImages()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = profilePhotoSize/2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    
    lazy var answerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clear
        label.font = UIFont.init(name: "Bubblegum", size: 50)
        label.attributedText = NSAttributedString(string: "?", attributes: strokeTextAttributes)
        
        return label
    }()
    
    lazy var winnderOutline: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.1764705882, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = profilePhotoSize/2
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var looserOutline: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = profilePhotoSize/2
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var winnderInnderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9097272158, green: 0.9098548293, blue: 0.9096869826, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 45
        view.clipsToBounds = true
        
        return view
    }()
    lazy var looserInnerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9097272158, green: 0.9098548293, blue: 0.9096869826, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 45
        view.clipsToBounds = true
        
        return view
    }()
    
    
    lazy var winnerAnswerLabel: UILabel = {
        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clear
        label.font = UIFont.init(name: "Bubblegum", size: 30)
        label.attributedText = NSAttributedString(string: "110", attributes: strokeTextAttributes)
        label.textAlignment = .center

        return label
    }()
    
    lazy var looserAnswerLabel: UILabel = {
        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clear
        label.font = UIFont.init(name: "Bubblegum", size: 30)
        label.attributedText = NSAttributedString(string: "90", attributes: strokeTextAttributes)
        label.textAlignment = .center
        
        
        return label
    }()
    
    
    
    
    
    
    

    override func viewDidLayoutSubviews() {
        borderLayer.path = UIBezierPath(roundedRect: questionMarkHolder.bounds, cornerRadius: 55).cgPath
        //setMyDashedLine()
        setFrontViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
    
    
    fileprivate func setupViews(){
        view.backgroundColor = #colorLiteral(red: 0.9097272158, green: 0.9098548293, blue: 0.9096869826, alpha: 1)
        setupQuestionHolder()
        setupQuestionLabel()
        setupQuestionMarkHolder()
        setupAnswerLabel()
        setupMyProfilePhoto()
        setupOpponentProfilePhoto()

    }
    
    
    var questionHolderHeightAnchor: NSLayoutConstraint!
    private func setupQuestionHolder(){
        view.addSubview(questionHolderView)
        questionHolderHeightAnchor = questionHolderView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([
            questionHolderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionHolderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            questionHolderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            questionHolderHeightAnchor
        ])
    }
    private func setupQuestionLabel(){
        questionHolderView.addSubview(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: questionHolderView.topAnchor, constant: 9),
            questionLabel.leadingAnchor.constraint(equalTo: questionHolderView.leadingAnchor, constant: 7),
            questionLabel.trailingAnchor.constraint(equalTo: questionHolderView.trailingAnchor, constant: -7),
            questionLabel.bottomAnchor.constraint(equalTo: questionHolderView.bottomAnchor, constant: -9)
        ])
    }
    private func setupQuestionMarkHolder(){
        view.addSubview(questionMarkHolder)
        NSLayoutConstraint.activate([
            questionMarkHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionMarkHolder.widthAnchor.constraint(equalToConstant: 110),
            questionMarkHolder.heightAnchor.constraint(equalToConstant: 110),
            questionMarkHolder.topAnchor.constraint(equalTo: questionHolderView.bottomAnchor, constant: 25)
        ])
        setQuestionMarkBorder()
    }
    private func setupAnswerLabel(){
        questionMarkHolder.addSubview(answerLabel)
        NSLayoutConstraint.activate([
            answerLabel.centerXAnchor.constraint(equalTo: questionMarkHolder.centerXAnchor),
            answerLabel.centerYAnchor.constraint(equalTo: questionMarkHolder.centerYAnchor)
        ])
    }
    
    var myLeadingConstraint: NSLayoutConstraint?
    var myBottomConstraint:  NSLayoutConstraint?
    
    var opponentTrailingConstraint: NSLayoutConstraint?
    var opponentBottomConstraint:  NSLayoutConstraint?
       
    
    private func setupMyProfilePhoto(){
        view.addSubview(myProfilePhoto)
        myLeadingConstraint = myProfilePhoto.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        myBottomConstraint = myProfilePhoto.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        NSLayoutConstraint.activate([
            myBottomConstraint!,
            myLeadingConstraint!,
            myProfilePhoto.widthAnchor.constraint(equalToConstant: profilePhotoSize),
            myProfilePhoto.heightAnchor.constraint(equalToConstant: profilePhotoSize)
        ])
    }
    private func setupOpponentProfilePhoto(){
        view.addSubview(opponentProfilePhoto)
        
        opponentTrailingConstraint =  opponentProfilePhoto.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        opponentBottomConstraint = opponentProfilePhoto.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        NSLayoutConstraint.activate([
            opponentBottomConstraint!,
           opponentTrailingConstraint!,
            opponentProfilePhoto.widthAnchor.constraint(equalToConstant: profilePhotoSize),
            opponentProfilePhoto.heightAnchor.constraint(equalToConstant: profilePhotoSize)
        ])
    }
    
    
    fileprivate func setMyDashedLine(){
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = UIColor.black.cgColor
        caShapeLayer.lineDashPattern = [3,3]
        caShapeLayer.backgroundColor = UIColor.clear.cgColor
        caShapeLayer.fillColor = UIColor.clear.cgColor
        view.layoutIfNeeded()
        let cgPath = CGMutablePath()
        
        let questionMarkMidY = questionHolderView.frame.height + 20 + 80

        let profilePhotoPoints: CGPoint = CGPoint(x: myProfilePhoto.frame.midX, y: myProfilePhoto.frame.midY)
        let questionMarkHolderPoints: CGPoint = CGPoint(x: view.frame.midX, y: questionMarkMidY)
        let cgPoint = [questionMarkHolderPoints, profilePhotoPoints]
        cgPath.addLines(between: cgPoint)
        
        caShapeLayer.path = cgPath
        view.layer.addSublayer(caShapeLayer)
    }
    
    
    
    
    
    
    
    
    
    fileprivate func setFrontViews(){
        view.bringSubviewToFront(myProfilePhoto)
        view.bringSubviewToFront(questionMarkHolder)
    }

    fileprivate func setQuestionMarkBorder(){
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineDashPattern = [3,3]
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        
        
        questionMarkHolder.layer.addSublayer(borderLayer)
        
    }
    
    //MARK:- Animations
    @objc func handleAnimation(){
        animateToWin()
           
       }
       fileprivate func animateToWin(){
           opponentTrailingConstraint!.constant = -75
           opponentBottomConstraint!.constant = -view.frame.height / 4
           
           myLeadingConstraint!.constant = 75
           myBottomConstraint!.constant = -view.frame.height / 4
           UIView.animate(withDuration: 5) {
               self.view.layoutIfNeeded()
           }
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 4.8) {
               UIView.animate(withDuration: 0.5) {
                   self.myProfilePhoto.transform = CGAffineTransform(rotationAngle:  CGFloat.pi)

                   self.myProfilePhoto.transform = CGAffineTransform(rotationAngle:  CGFloat.pi * 2)

               }
            
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                  
                   self.myLeadingConstraint!.constant = ((self.view.frame.width / 2) - self.myProfilePhoto.frame.width / 2) - 40
                self.myBottomConstraint!.constant = -self.view.frame.height / 2.5
                UIView.animate(withDuration: 3, animations: {
                    self.view.layoutIfNeeded()
                    
                }) { (isFinished) in
                    if(isFinished){
                        self.handleShowAnswers()
                    }
                }
                
               }
           }
       }
    
    
    private func handleShowAnswers(){
        
        
        answerLabel.text = "125"
        
        view.addSubview(winnderOutline)
        view.addSubview(winnderInnderLine)
        winnderOutline.frame = myProfilePhoto.frame
        
        
        myProfilePhoto.image = nil
        opponentProfilePhoto.image = nil
        
        
        winnderInnderLine.frame = winnderOutline.frame
        winnderInnderLine.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        
        
        view.addSubview(looserOutline)
        view.addSubview(looserInnerLine)
        looserOutline.frame = opponentProfilePhoto.frame
        looserInnerLine.frame = looserOutline.frame
        
        looserInnerLine.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        
        
        //Answers:
        view.addSubview(winnerAnswerLabel)
        view.addSubview(looserAnswerLabel)
        
        
        view.layoutIfNeeded()
        looserInnerLine.layoutIfNeeded()
        winnderInnderLine.layoutIfNeeded()
        
        winnerAnswerLabel.frame = winnderInnderLine.frame
        looserAnswerLabel.frame = looserInnerLine.frame
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let round = self.gameRoom!.round
            let nextRound = round + 1
            let gameRoomRef = self.ref.child(self.gameRoom!.roomId).updateChildValues(["round":String(nextRound)]) { (error, ref) in
                if let err = error{
                    print("Hata oluştu!!! - \(err)")
                }
                var nextGameRoom = self.gameRoom!
                nextGameRoom.round = nextRound
                
                let controller = GamePlayViewController()
                controller.gameRoom = nextGameRoom
                controller.modalPresentationStyle = .overFullScreen
                self.present(controller, animated: true, completion: nil)
                
                
            }
        }
        

    }
    
    // MARK:- Previes
    struct WalkToWinViewView: View {
        var body: some View{
            WalkToWinIntegratedController().edgesIgnoringSafeArea(.all)
        }
    }
    struct WalkToWinIntegratedController: UIViewControllerRepresentable{
        func updateUIViewController(_ uiViewController: WalkToWinViewControllerForTwo, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> WalkToWinViewControllerForTwo {
            return WalkToWinViewControllerForTwo()
        }
    }
    struct SamplePriviewPreview: PreviewProvider{
        static var previews: some View{
            WalkToWinViewView()
        }
    }
}




extension UIView {
   func createDottedLine(width: CGFloat, color: CGColor) {
      let caShapeLayer = CAShapeLayer()
    caShapeLayer.strokeColor = UIColor.black.cgColor
    caShapeLayer.lineDashPattern = [3,3]
    caShapeLayer.backgroundColor = UIColor.clear.cgColor
    caShapeLayer.fillColor = UIColor.clear.cgColor
    
    let cgPath = CGMutablePath()
    let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
    cgPath.addLines(between: cgPoint)
    
    caShapeLayer.path = cgPath
    layer.addSublayer(caShapeLayer)
    
    
    
    /*
      caShapeLayer.strokeColor = color
      caShapeLayer.lineWidth = width
      caShapeLayer.lineDashPattern = [3,3]
      let cgPath = CGMutablePath()
      let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
      cgPath.addLines(between: cgPoint)
      caShapeLayer.path = cgPath
      layer.addSublayer(caShapeLayer)
 */
   }
}
