//
//  ViewController.swift
//  SecondPage
//
//  Created by si zhang on 17/4/5.
//  Copyright © 2017年 si zhang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

// set up flag to help distinguish whether the button is pressed
var morningFlag: Int = 1
var lunchFlag: Int = 1
var dinnerFlag: Int = 1
var vegetableFlag: Int = 1
var lowfatFlag: Int = 1
var dietRestrictions = [String]()
//global instance for user information
var myUser = User(numPeople: 1, numMeals: 1, dietaryRestrictions: [], uid: (FIRAuth.auth()?.currentUser?.uid)!)


class HomepageController: UIViewController {
    //set up image passed from Bundle object for Image Button
    var bundle: Bundles? {
        didSet {
            ImageButton.setImage(UIImage(named: (bundle?.imageName)!), for: .normal)
        }
    }
    var ref: FIRDatabaseReference!
    
    var parsedBundle = Bundles(id: 0, name: "1", category: "", imageName: "", price: 0.0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: [], preperations: [], ingredients: [:])
    //set up UI for label
    let titleLabel : UILabel = {
        let iv = UILabel()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.text = "This Week:"
        iv.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 24)
        iv.textColor = UIColor.white
        //iv.backgroundColor = UIColor.gray
        iv.numberOfLines = 1
        iv.layer.cornerRadius = 0
        
        return iv
    }()
    //set up UI for Bundle label
    let emptyBundleLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.black
        label.text = "Oops, your pandry is empty at this moment. Add your bundle of this week now!"
        label.backgroundColor = UIColor(white: 1, alpha: 0.6)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30)
        label.layer.masksToBounds = true
        label.numberOfLines = 3
        label.layer.cornerRadius = 10
        return label
    }()
    // set up UI for background
    let BgImage: UIImageView = {
        let theImageView = UIImageView()
        theImageView.contentMode = .scaleAspectFill
        theImageView.image = UIImage(named: "bg3x.png")
        theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
        return theImageView
    }()
    
    //effect instance
    var effect:UIVisualEffect!
    //set up UI for pop up view
    var addItemView: UIView = {
        var addItemView = UIView()
        addItemView.backgroundColor = UIColor.white
        addItemView.translatesAutoresizingMaskIntoConstraints = false
        addItemView.layer.cornerRadius = 5
        return addItemView
    }()
    var blurEffectView: UIVisualEffectView!
    
    //set up UI for clickable image view
    lazy var ImageButton: UIButton = {
        let BundleImage = UIImage(named: "foodphoto") as UIImage?
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(BundleImage, for: .normal)
        button.imageView?.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(goToBundle), for: .touchUpInside)
        return button
    }()
    
    //set up UI for button 1 on the pop up view: morning
    lazy var PopMorningButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Breakfast", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(MorningFunc), for: .touchUpInside)
        return button
    }()
    //set up UI for button 2 on the pop up view: lunch
    lazy var PopLunchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Lunch", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(LunchFunc), for: .touchUpInside)
        return button
    }()
    //set up UI for button 3 on the pop up view: dinner
    lazy var PopDinnerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Dinner", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(DinnerFunc), for: .touchUpInside)
        return button
    }()
    //set up UI for button 4 on the pop up view: vegetable
    lazy var PopVegetableButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("vegetarian", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(VegetableFunc), for: .touchUpInside)
        return button
    }()
    //set up UI for button 5 on the pop up view: low fat
    lazy var PopLowfatButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("low fat", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(LowfatFunc), for: .touchUpInside)
        return button
    }()
    
    //set up UI for button Cancel on the pop up view
    lazy var PopCancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.layer.cornerRadius = 5
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(dismissPop), for: .touchUpInside)
        return button
    }()
    //set up UI for button Save on the pop up view
    lazy var PopSaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.layer.cornerRadius = 5
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(goToNextView), for: .touchUpInside)
        return button
    }()
    
    //set up UI for Textfield: number of meal
    let mealTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Number of meal"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        return tf
    }()
    //set up UI for Textfield: number of people
    let peopleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Number of people"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        return tf
    }()
    //receive Jason data from firebase and set up the UI with received value
    func receiveDatafromDatabase() {
        DispatchQueue.main.async() {
            self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.childrenCount > 0 {
                    for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        guard let restDict = rest.value as? [String: AnyObject] else {
                            continue
                        }
                        self.parsedBundle.category = restDict["category"] as! String
                        self.parsedBundle.cookTime = restDict["cookTime"] as! Int
                        self.parsedBundle.id = restDict["id"] as! NSNumber
                        self.parsedBundle.imageName = restDict["imageName"] as! String
                        self.parsedBundle.name = restDict["name"]! as! String
                        self.parsedBundle.prepTime = restDict["prepTime"] as! Int
                        self.parsedBundle.price = restDict["price"] as! Float
                        self.parsedBundle.totalTime = restDict["totalTime"] as! Int
                        self.parsedBundle.ingredients = restDict["ingredients"] as! [String:[String]]
                        print((self.parsedBundle.name) + " added to home page")
                    }
                }
            }, withCancel: nil)
            
            self.ref.child("bundle").child("preperations").observe(.value, with: { (snapshot) in
                if snapshot.childrenCount > 0 {
                    for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        guard let restDict = rest.value as? [String: AnyObject] else {
                            continue
                        }
                        let item = Preparation(url: "", prepTime: 0, desc: "", imageName: "")
                        item.desc = restDict["desc"] as! String
                        item.imageName = restDict["imageName"] as! String
                        item.prepTime = restDict["prepTime"] as! Int
                        item.url = restDict["url"] as! String
                        self.parsedBundle.preperations.append(item)
                    }
                }
            })
            
            self.ref.child("bundle").child("recipes").observe(.value, with: { (snapshot) in
                if snapshot.childrenCount > 0 {
                    for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        guard let restDict = rest.value as? [String: AnyObject] else {
                            continue
                        }
                        let item = Recipe(id: 0, name: "", category: "", preparationArray: [], imageName: "", price: 0, cookTime: 0, tag: [], ingredients: [:], steps: [[]], details: "")
                        item.category = restDict["category"] as! String
                        item.cookTime = restDict["cookTime"] as! Int
                        item.details = restDict["details"] as! String
                        item.id = restDict["id"] as! NSNumber
                        item.imageName = restDict["imageName"] as! String
                        item.price = restDict["price"] as! Float
                        item.steps = restDict["steps"] as! [[String]]
                        item.tag = restDict["tag"] as! [String]
                        item.name = restDict["name"] as! String
                        self.parsedBundle.recipes.append(item)
                        
                    }
                }
                
            })
            
        }
        
        let additionalTime: DispatchTimeInterval = .milliseconds(500)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + additionalTime) {
            if self.parsedBundle.imageName != "" {
            
                self.view.addSubview(self.ImageButton)
                self.view.addSubview(self.titleLabel)
                self.setupTitleLabel()
                self.setUpImageButton()
                self.ImageButton.setImage(UIImage(named: self.parsedBundle.imageName), for: .normal)
            
            }
        
            if self.parsedBundle.imageName == "" && self.bundle?.imageName == nil {
                print(self.parsedBundle.name)
            
                self.view.addSubview(self.emptyBundleLabel)
                self.setupEmptyBundleLabel()
            }
        
        }

    }

    //view did load
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let uid1 = FIRAuth.auth()?.currentUser?.uid
        ref = FIRDatabase.database().reference().child("user").child(uid1!)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomepageController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //add background
        view.addSubview(BgImage)
        someImageViewConstraints()
        // add blur effect
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)//这有问题想办法放到外面
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        effect = blurEffectView.effect
        blurEffectView.effect = nil
        receiveDatafromDatabase()
        //naviagation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Bundle", style: .plain, target: self, action: #selector(handlePopOver))
        navigationItem.backBarButtonItem?.isEnabled = false
        let imageLeft = UIImage(named: "user29")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageLeft, style: .plain, target: self, action: #selector(goToAccount))
        //check
        checkIfUserIsLoggedIn()
    }
    
    //check if the user is logged in, if it is not, go to the logedin view
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
        }
    }
    //log out function
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    //go to account view function
    func goToAccount(){
        let newMessageController = AccountViewController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //set up animation for appearance of the pop view
    func animateIn(){
        view.addSubview(addItemView)
        SetUpPopUpView()
        addItemView.transform = CGAffineTransform.init(scaleX:1.3, y:1.3)
        addItemView.alpha = 0;
        UIView.animate(withDuration: 0.4) {
            self.blurEffectView.effect = self.effect
            self.addItemView.alpha = 1
            self.addItemView.transform = CGAffineTransform.identity
        }
        addItemView.addSubview(PopCancelButton)
        addItemView.addSubview(PopSaveButton)
        //add input textfieds in pop up view
        addItemView.addSubview(mealTextField)
        addItemView.addSubview(peopleTextField)
        addItemView.addSubview(PopMorningButton)
        addItemView.addSubview(PopLunchButton)
        addItemView.addSubview(PopDinnerButton)
        addItemView.addSubview(PopVegetableButton)
        addItemView.addSubview(PopLowfatButton)
        //add constraint for these text fields
        SetUpInputInPupUp()
        setupPopButton()
        setupSaveButton()
        setupMorningButton()
        setupLunchButton()
        setupDinnerButton()
        setupVegetableButton()
        setupLowfatButton()
    }
    //set up animation for disappearance of the pop view
    func animateOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.addItemView.transform = CGAffineTransform.init(scaleX:1.3, y:1.3)
            self.addItemView.alpha=0
            self.blurEffectView.effect = nil
        }) { (success:Bool) in
            self.addItemView.removeFromSuperview()
        }
    }
    
    func dismissPop(){
        animateOut()
    }
    
    func goToNextView(){
        myUser.numMeals = Int(mealTextField.text!) ?? 1
        myUser.numPeople = Int(peopleTextField.text!) ?? 1
        myUser.dietaryRestrictions = dietRestrictions
        let layout =  UICollectionViewFlowLayout()
        let newMessageController = FeaturedBundlesController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: newMessageController)
        navigationController?.show(navController, sender: self)
    }
    //set up constraints for all UI components
    func SetUpInputInPupUp(){
        //number of meal
        mealTextField.centerXAnchor.constraint(equalTo: addItemView.centerXAnchor).isActive = true
        mealTextField.topAnchor.constraint(equalTo: addItemView.topAnchor, constant: 20).isActive = true
        mealTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mealTextField.heightAnchor.constraint(equalTo: addItemView.heightAnchor, multiplier: 1/5)
        //number of people
        peopleTextField.centerXAnchor.constraint(equalTo: addItemView.centerXAnchor).isActive = true
        peopleTextField.topAnchor.constraint(equalTo: mealTextField.bottomAnchor, constant: 10).isActive = true
        peopleTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        peopleTextField.heightAnchor.constraint(equalTo: addItemView.heightAnchor, multiplier: 1/5)
    }
    
    func SetUpPopUpView() {
        addItemView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addItemView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        addItemView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        addItemView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
    }
    
    func someImageViewConstraints() {
        BgImage.widthAnchor.constraint(equalTo:self.view.widthAnchor).isActive = true
        BgImage.heightAnchor.constraint(equalTo:self.view.heightAnchor).isActive = true
    }
    
    func setupEmptyBundleLabel() {
        emptyBundleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyBundleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:+80).isActive = true
        emptyBundleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        emptyBundleLabel.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        emptyBundleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupTitleLabel() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.widthAnchor, constant: 100).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpImageButton() {
        ImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ImageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: +110).isActive = true
        ImageButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        ImageButton.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
    }
    
    func setupPopButton() {
        //need x, y, width, height constraints
        PopCancelButton.centerXAnchor.constraint(equalTo: addItemView.centerXAnchor).isActive = true
        PopCancelButton.centerYAnchor.constraint(equalTo: addItemView.bottomAnchor, constant: -20).isActive = true
        PopCancelButton.widthAnchor.constraint(equalTo: addItemView.widthAnchor, constant: -24).isActive = true
        PopCancelButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupSaveButton() {
        //need x, y, width, height constraints
        PopSaveButton.centerXAnchor.constraint(equalTo: addItemView.centerXAnchor).isActive = true
        PopSaveButton.centerYAnchor.constraint(equalTo: PopCancelButton.topAnchor, constant: -20).isActive = true
        PopSaveButton.widthAnchor.constraint(equalTo: addItemView.widthAnchor, constant: -24).isActive = true
        PopSaveButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func goToBundle(){
        let layout =  UICollectionViewFlowLayout()
        let newMessageController = SecondBundleDetailController(collectionViewLayout: layout)
        newMessageController.bundle = self.parsedBundle
        _ = UINavigationController(rootViewController: newMessageController)
        navigationController?.pushViewController(newMessageController, animated: true)
    }
    
    func handlePopOver(){
        animateIn()
    }
    
    //button 1: morning
    func setupMorningButton() {
        //need x, y, width, height constraints
        PopMorningButton.rightAnchor.constraint(equalTo: PopLunchButton.leftAnchor, constant: -15).isActive = true
        PopMorningButton.centerYAnchor.constraint(equalTo: PopVegetableButton.topAnchor, constant: -30).isActive = true
        PopMorningButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        PopMorningButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    //button 2: lunch
    func setupLunchButton() {
        //need x, y, width, height constraints
        PopLunchButton.centerXAnchor.constraint(equalTo: addItemView.centerXAnchor).isActive = true
        PopLunchButton.centerYAnchor.constraint(equalTo: PopVegetableButton.topAnchor, constant: -30).isActive = true
        PopLunchButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        PopLunchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    //button 3: dinner
    func setupDinnerButton() {
        //need x, y, width, height constraints
        PopDinnerButton.leftAnchor.constraint(equalTo: PopLunchButton.rightAnchor, constant: 15).isActive = true
        PopDinnerButton.centerYAnchor.constraint(equalTo: PopVegetableButton.topAnchor, constant: -30).isActive = true
        PopDinnerButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        PopDinnerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    //button 4: vegetable
    func setupVegetableButton() {
        //need x, y, width, height constraints
        PopVegetableButton.leftAnchor.constraint(equalTo: addItemView.leftAnchor, constant: 60).isActive = true
        PopVegetableButton.centerYAnchor.constraint(equalTo: PopSaveButton.topAnchor, constant: -30).isActive = true
        PopVegetableButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        PopVegetableButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    //button 5: low fat
    func setupLowfatButton() {
        //need x, y, width, height constraints
        PopLowfatButton.rightAnchor.constraint(equalTo: addItemView.rightAnchor, constant: -70).isActive = true
        PopLowfatButton.centerYAnchor.constraint(equalTo: PopSaveButton.topAnchor, constant: -30).isActive = true
        PopLowfatButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        PopLowfatButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    //function help to distinguish whether the button is pressed. If it is, the color of the button will change into blue
    func MorningFunc(){
        morningFlag = morningFlag*(-1)
        if morningFlag == -1 {
            PopMorningButton.backgroundColor = UIColor(r: 80, g: 101, b: 161)
            dietRestrictions.append((PopMorningButton.titleLabel?.text)!)
        }
        if morningFlag == 1{
            PopMorningButton.backgroundColor = UIColor.clear
            if let index = dietRestrictions.index(of: (PopMorningButton.titleLabel?.text)!){
                dietRestrictions.remove(at: index)
            }
        }
    }
    func LunchFunc(){
        lunchFlag = lunchFlag*(-1)
        if lunchFlag == -1 {
            PopLunchButton.backgroundColor = UIColor(r: 80, g: 101, b: 161)
            dietRestrictions.append((PopLunchButton.titleLabel?.text)!)
        }
        if lunchFlag == 1{
            PopLunchButton.backgroundColor = UIColor.clear
            if let index = dietRestrictions.index(of: (PopLunchButton.titleLabel?.text)!){
                dietRestrictions.remove(at: index)
            }
        }
    }
    func DinnerFunc(){
        dinnerFlag = dinnerFlag*(-1)
        if dinnerFlag == -1 {
            PopDinnerButton.backgroundColor = UIColor(r: 80, g: 101, b: 161)
            dietRestrictions.append((PopDinnerButton.titleLabel?.text)!)
        }
        if dinnerFlag == 1{
            PopDinnerButton.backgroundColor = UIColor.clear
            if let index = dietRestrictions.index(of: (PopDinnerButton.titleLabel?.text)!){
                dietRestrictions.remove(at: index)
            }
        }
    }
    func VegetableFunc(){
        vegetableFlag = vegetableFlag*(-1)
        if vegetableFlag == -1 {
            PopVegetableButton.backgroundColor = UIColor(r: 80, g: 101, b: 161)
            dietRestrictions.append((PopVegetableButton.titleLabel?.text)!)
        }
        if vegetableFlag == 1{
            PopVegetableButton.backgroundColor = UIColor.clear
            if let index = dietRestrictions.index(of: (PopVegetableButton.titleLabel?.text)!){
                dietRestrictions.remove(at: index)
            }
        }
    }
    func LowfatFunc(){
        lowfatFlag = lowfatFlag*(-1)
        if lowfatFlag == -1 {
            PopLowfatButton.backgroundColor = UIColor(r: 80, g: 101, b: 161)
            dietRestrictions.append((PopLowfatButton.titleLabel?.text)!)
        }
        if lowfatFlag == 1{
            PopLowfatButton.backgroundColor = UIColor.clear
            if let index = dietRestrictions.index(of: (PopLowfatButton.titleLabel?.text)!){
                dietRestrictions.remove(at: index)
            }
        }
    }
    
}


extension UIViewController {
    func dismissKeyboardFromView(sender: UITapGestureRecognizer?) {
        let view = sender?.view
        view?.endEditing(true)
    }
}

