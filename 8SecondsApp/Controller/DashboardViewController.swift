//
//  DashboardViewController.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 21.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class DashboardViewController: UIViewController {
    var ref: DatabaseReference!
    
    var topUsers:[User] = [User](){
        didSet{
            chartsCollectionView.reloadData()
        }
    }

    private let leadershipCellIdentifier: String = "leadershipCellIdentifier"
    let historyCellIdentifier: String = "historyCellIdentifier"
    
    let adView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    let adTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "REKLAM"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    
    // ------------------------------ Reklam Bitti ------------------------------------- //
    
    let topContentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9097272158, green: 0.9098548293, blue: 0.9096869826, alpha: 1)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        
        return view
    }()
    let profilePhotoImageView: RemoteImages = {
        let iv = RemoteImages(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 1
        iv.layer.cornerRadius = 35
        iv.clipsToBounds = true
        
        return iv
    }()
    lazy var quickPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.setTitle("HEMEN OYNA", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(quickPlayHandler), for: .touchUpInside)
        
        return button
    }()
    let playWithFriendsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.setTitle("ARKADAŞLARINLA OYNA", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return button
    }()
    lazy var leadershipTableButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Lider Tablosu", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = #colorLiteral(red: 0.9332545996, green: 0.9333854914, blue: 0.9332134128, alpha: 1)
        button.addTarget(self, action: #selector(leadershipButtonHandler), for: .touchUpInside)
        
        return button
    }()
    lazy var historyTableButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Karşılaşma Geçmişi", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.6744517684, green: 0.6745483279, blue: 0.6744213104, alpha: 1)
        button.addTarget(self, action: #selector(historyButtonHandler), for: .touchUpInside)
        
        return button
    }()
    let chartsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = #colorLiteral(red: 0.9332545996, green: 0.9333854914, blue: 0.9332134128, alpha: 1)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        
        
        return cv
    }()
    let bottomHolderView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    let coinImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "coin"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let coinLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2800"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        view.backgroundColor = #colorLiteral(red: 0.9332545996, green: 0.9333854914, blue: 0.9332134128, alpha: 1)
        setupViews()
    }
    
    
    private func setupViews(){
        setupAdBanner()
        setupTopHolder()
        setupProfilePhoto()
        setupQuickPlayButton()
        setupPlayWithFriendsButton()
        setupChartButtons()
        setupChartCollectionView()
        setupBottomHolder()
        setupCoinImageView()
        setupCoinLabel()
        
        setupFirebase()
    }
    
    private func setupAdBanner(){
        view.addSubview(adView)
        NSLayoutConstraint.activate([
            adView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            adView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            adView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        adView.addSubview(adTitle)
        NSLayoutConstraint.activate([
            adTitle.centerYAnchor.constraint(equalTo: adView.centerYAnchor),
            adTitle.centerXAnchor.constraint(equalTo: adView.centerXAnchor)
        ])
    }
    private func setupTopHolder(){
        let requiredHeight: CGFloat = 300 //  10    + 10  -- 260
        view.addSubview(topContentView)
        NSLayoutConstraint.activate([
            topContentView.topAnchor.constraint(equalTo: adView.topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContentView.heightAnchor.constraint(equalToConstant: requiredHeight)
        ])
    }
    private func setupProfilePhoto(){
        topContentView.addSubview(profilePhotoImageView)
        NSLayoutConstraint.activate([
            profilePhotoImageView.topAnchor.constraint(equalTo: topContentView.topAnchor, constant: 10),
            profilePhotoImageView.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 10),
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: 70),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
    }
    private func setupQuickPlayButton(){
        topContentView.addSubview(quickPlayButton)
        NSLayoutConstraint.activate([
            quickPlayButton.centerXAnchor.constraint(equalTo: topContentView.centerXAnchor),
            quickPlayButton.heightAnchor.constraint(equalToConstant: 70),
            quickPlayButton.widthAnchor.constraint(equalTo: topContentView.widthAnchor, multiplier: 0.6),
            quickPlayButton.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 25)
        ])
    }
    private func setupPlayWithFriendsButton(){
        topContentView.addSubview(playWithFriendsButton)
        NSLayoutConstraint.activate([
            playWithFriendsButton.widthAnchor.constraint(equalTo: quickPlayButton.widthAnchor),
            playWithFriendsButton.heightAnchor.constraint(equalTo: quickPlayButton.heightAnchor),
            playWithFriendsButton.topAnchor.constraint(equalTo: quickPlayButton.bottomAnchor, constant: 15),
            playWithFriendsButton.centerXAnchor.constraint(equalTo: quickPlayButton.centerXAnchor)
        ])
    }
    private func setupChartButtons(){
        view.layoutIfNeeded()
        
        let width = view.frame.width
        view.addSubview(leadershipTableButton)
        NSLayoutConstraint.activate([
            leadershipTableButton.topAnchor.constraint(equalTo: topContentView.bottomAnchor),
            leadershipTableButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            leadershipTableButton.heightAnchor.constraint(equalToConstant: 40),
            leadershipTableButton.widthAnchor.constraint(equalToConstant: (width * 0.5) - 2)
        ])
        view.addSubview(historyTableButton)
        NSLayoutConstraint.activate([
            historyTableButton.centerYAnchor.constraint(equalTo: leadershipTableButton.centerYAnchor),
            historyTableButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            historyTableButton.heightAnchor.constraint(equalTo: leadershipTableButton.heightAnchor),
            historyTableButton.widthAnchor.constraint(equalToConstant: (width * 0.5) - 2)
        ])
    }
    private func setupChartCollectionView(){
        view.addSubview(chartsCollectionView)
        NSLayoutConstraint.activate([
            chartsCollectionView.topAnchor.constraint(equalTo: leadershipTableButton.bottomAnchor),
            chartsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
        chartsCollectionView.delegate = self
        chartsCollectionView.dataSource = self
        
        chartsCollectionView.register(DashboardLeadershipHolderViewCell.self, forCellWithReuseIdentifier: leadershipCellIdentifier)
        chartsCollectionView.register(DashboardHistoryHolderViewCellCollectionViewCell.self, forCellWithReuseIdentifier: historyCellIdentifier)
    }
    private func setupBottomHolder(){
        view.addSubview(bottomHolderView)
        NSLayoutConstraint.activate([
            bottomHolderView.topAnchor.constraint(equalTo: chartsCollectionView.bottomAnchor),
            bottomHolderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomHolderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomHolderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func setupCoinImageView(){
        bottomHolderView.addSubview(coinImageView)
        NSLayoutConstraint.activate([
            coinImageView.bottomAnchor.constraint(equalTo: bottomHolderView.bottomAnchor, constant: -9),
            coinImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            coinImageView.heightAnchor.constraint(equalToConstant: 22),
            coinImageView.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    private func setupCoinLabel(){
        view.addSubview(coinLabel)
        NSLayoutConstraint.activate([
            coinLabel.centerYAnchor.constraint(equalTo: coinImageView.centerYAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10)
        ])
    }
    
    
    //MARK:- Handlers:
    @objc private func leadershipButtonHandler(){
        leadershipTableButton.backgroundColor = #colorLiteral(red: 0.9332545996, green: 0.9333854914, blue: 0.9332134128, alpha: 1)
        leadershipTableButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)

        historyTableButton.backgroundColor = #colorLiteral(red: 0.6744517684, green: 0.6745483279, blue: 0.6744213104, alpha: 1)
        historyTableButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        
        scrollToPage(pageIndex: 0)
    }
    @objc private func historyButtonHandler(){
        leadershipTableButton.backgroundColor = #colorLiteral(red: 0.6744517684, green: 0.6745483279, blue: 0.6744213104, alpha: 1)
        leadershipTableButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        historyTableButton.backgroundColor = #colorLiteral(red: 0.9332545996, green: 0.9333854914, blue: 0.9332134128, alpha: 1)
        historyTableButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
       
        scrollToPage(pageIndex: 1)
    }
    
    
    var gameRoom: GameRoom?{
        didSet{
            let gamePlayViewController = GamePlayViewController()
            gamePlayViewController.modalPresentationStyle = .overFullScreen
            gamePlayViewController.gameRoom = gameRoom

            self.present(gamePlayViewController, animated: true, completion: nil)
            
        }
    }
    
    @objc private func quickPlayHandler(){
        
        Vibration.selection.vibrate()
        
        let gameRoomsRef = ref.child("gameRooms").queryOrdered(byChild: "status").queryEqual(toValue: "Waiting")
        gameRoomsRef.observeSingleEvent(of: .value) { (snapshot) in
            
            if snapshot.childrenCount > 0{
                
                for child in snapshot.children{
                    let snap = child as! DataSnapshot
                    if let dictionary = snap.value as? [String: Any]{
                        var dictToUpload = dictionary
                        let admin = dictionary["admin"] as? String ?? ""
                        
                        let roomId = dictionary["roomId"] as? String ?? ""
                        let status = dictionary["status"] as? String ?? ""
                        let round = dictionary["round"] as? Int ?? 0
                       
                        
                        
                        let firstQuestion     = dictionary["firstQuestion"] as? String ?? ""
                        let firstAnswer       = dictionary["firstAnswer"] as? String ?? ""
                        let secondQuestion    = dictionary["secondQuestion"] as? String ?? ""
                        let secondAnswer      = dictionary["secondAnswer"] as? String ?? ""
                        let thirdQuestion     = dictionary["thirdQuestion"] as? String ?? ""
                        let thirdAnswer       = dictionary["thirdAnswer"] as? String ?? ""
                        let fourthQuestion    = dictionary["fourthQuestion"] as? String ?? ""
                        let fourthAnswer      = dictionary["fourthAnswer"] as? String ?? ""
                        let fiftQhuestion     = dictionary["fiftQhuestion"] as? String ?? ""
                        let fifthAnswer       = dictionary["fifthAnswer"] as? String ?? ""
                        let adminAnswer       = dictionary["adminAnswer"] as? String ?? ""
                        let playerAnswer      = dictionary["playerAnswer"] as? String ?? ""
                        
                        //-----
                        let player = Auth.auth().currentUser?.uid
                        dictToUpload["player"] = player
                        //----
                        
                        self.gameRoom = GameRoom(admin: admin, player: Auth.auth().currentUser!.uid, roomId: roomId, status: status, round: round, firstQuestion: firstQuestion, secondQuestion: secondQuestion, thirdQuestion: thirdQuestion, fourthQuestion: fourthQuestion, fiftQuestion: fiftQhuestion, firstAnswer: firstAnswer, secondAnswer: secondAnswer, thirdAnswer: thirdAnswer, fourthAnswer: fourthAnswer, fifthAnswer: fifthAnswer, adminAnswer: adminAnswer, playerAnswer: playerAnswer)
                        
                        
                        
                        self.ref.child("gameRooms").child(roomId).updateChildValues(["player":Auth.auth().currentUser?.uid, "status": "InGame"]) { (error, ref) in
                            if let error = error{
                                self.makeAlert(alertMessage: error.localizedDescription)
                                return
                            }
                        }
                    }
                    
                    
                }
                

            }else{
                self.createGameRoom()
            }
        }
    }
    var questionsToUse: Questions?{
        didSet{
            insertQuestionIntoDatabase()
        }
    }
    private func createGameRoom(){
        getQuestions()
    }
    
    
    private func getQuestions(){
        QuestionsService.getQuestions { (questions) in
            DispatchQueue.main.async {
                if questions.questions.count < 6{
                    self.getQuestions()
                }else{
                    self.questionsToUse = questions
                }
            }
        }
    }
    
    private func insertQuestionIntoDatabase(){
        
        ref = Database.database().reference()
        let gameRoomId = UUID().uuidString
        let gameRoomDictionary : [String : Any] = [
            "admin": Auth.auth().currentUser!.uid,
            "status": "Waiting",
            "roomId": gameRoomId,
            "round": 0,
            "player": "-1",
            "firstQuestion": questionsToUse!.questions[0].question,
            "secondQuestion": questionsToUse!.questions[1].question,
            "thirdQuestion": questionsToUse!.questions[2].question,
            "fourthQuestion": questionsToUse!.questions[3].question,
            "fifthQuestion": questionsToUse!.questions[4].question,
            "firstAnswer": questionsToUse!.questions[0].answer,
            "secondAnswer": questionsToUse!.questions[1].answer,
            "thirdAnswer": questionsToUse!.questions[2].answer,
            "fourthAnswer": questionsToUse!.questions[3].answer,
            "fifthAnswer": questionsToUse!.questions[4].answer,
            "adminAnswer": "-1",
            "playerAnswer": "-1,"
        ]
        
        
        ref.child("gameRooms").child(gameRoomId).setValue(gameRoomDictionary){
            (error: Error?, ref: DatabaseReference) in
            if error != nil{
                self.makeAlert(alertMessage: "Bir Hata Oluştu.")
                return
            }else{
                DispatchQueue.main.async {
                    self.gameRoom = GameRoom(admin: Auth.auth().currentUser!.uid,
                                             player: "-1",
                                             roomId: gameRoomId,
                                             status: "Waiting",
                                             round: 0,
                                             firstQuestion: self.questionsToUse!.questions[0].question,
                                             secondQuestion: self.questionsToUse!.questions[1].question,
                                             thirdQuestion: self.questionsToUse!.questions[2].question,
                                             fourthQuestion: self.questionsToUse!.questions[3].question,
                                             fiftQuestion: self.questionsToUse!.questions[4].question,
                                             firstAnswer: self.questionsToUse!.questions[0].answer,
                                             secondAnswer: self.questionsToUse!.questions[1].answer,
                                             thirdAnswer: self.questionsToUse!.questions[2].answer,
                                             fourthAnswer: self.questionsToUse!.questions[3].answer,
                                             fifthAnswer: self.questionsToUse!.questions[4].answer,
                                             adminAnswer: "-1",
                                             playerAnswer: "-1")
                    
                    
                    
                    
                }
            }
        }
        
        
    }
    
    
    
    
    private func makeAlert(alertMessage: String){
        let alert = UIAlertController(title: "Uyarı", message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    private func scrollToPage(pageIndex: Int){
        let indexPath: IndexPath = IndexPath(item: pageIndex, section: 0)
        chartsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x / chartsCollectionView.frame.width
        if Int(x) == 0{
            leadershipButtonHandler()
        }else{
            historyButtonHandler()
        }
    }
    
    
    
    
    
    
    
    //MARK:- Firebase Database --
    
    private func setupFirebase(){
        setUserProfilePhoto()
        setLeadershipTable()
    }
    
    private func setUserProfilePhoto(){
        if let profilePhotoUrl = currentUser?.profilePhoto{
            profilePhotoImageView.loadImageUsingUrlString(urlString: profilePhotoUrl)
        }else{
            profilePhotoImageView.image = #imageLiteral(resourceName: "launchLogo")
        }
    }
    
    
    private func setLeadershipTable(){
        let topUsersRef = (ref.child("users").queryOrdered(byChild: "totalPoint").queryLimited(toLast: 20))
        
        topUsersRef.observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any]{
                let uid = dictionary["id"] as? String  ?? ""
                let fullname = dictionary["name"] as? String ?? ""
                let city = dictionary["city"] as? String ?? ""
                let sex = dictionary["sex"] as? String ?? ""
                let birthday = dictionary["birthday"] as? String ?? ""
                let email = dictionary["email"] as? String ?? ""
                let profilePhoto = dictionary["profilePhoto"] as? String ?? ""
                let totalPoint = dictionary["totalPoint"] as? Int ?? -1
                
                let oneOfUser = User(uid: uid, fullname: fullname, city: city, sex: sex, birthday: birthday, email: email, profilePhoto: profilePhoto, totalPoint: totalPoint)
                
                self.topUsers.append(oneOfUser)

            }
        }
        
        
        
    }
    
}





//MARK:- Collection View Delegation extensions:
extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1{
            let historyCell = collectionView.dequeueReusableCell(withReuseIdentifier: historyCellIdentifier, for: indexPath) as! DashboardHistoryHolderViewCellCollectionViewCell
            
            return historyCell
        }
        let leadershipCell = collectionView.dequeueReusableCell(withReuseIdentifier: leadershipCellIdentifier, for: indexPath) as! DashboardLeadershipHolderViewCell
        
        leadershipCell.users = topUsers.reversed()
        
        
        return leadershipCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        view.layoutIfNeeded()
        return .init(width: view.frame.width, height: chartsCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}



