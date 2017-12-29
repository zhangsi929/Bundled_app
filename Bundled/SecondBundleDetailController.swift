//
//  bundleDetailController.swift
//  AppStore
//
//  Created by Wenqi Wang on 26/03/2017.
//  Copyright © 2017 Wenqi Wang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class SecondBundleDetailController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var bundle: Bundles? {
        didSet {
            //navigationItem.title = bundle?.name
            /*parsedBundle.id = (bundle?.id)!
            parsedBundle.category = (bundle?.category)!
            parsedBundle.name = (bundle?.name)!
            parsedBundle.imageName = (bundle?.imageName)!
            parsedBundle.price = (bundle?.price)!
            parsedBundle.cookTime = (bundle?.cookTime)!
            parsedBundle.prepTime = (bundle?.prepTime)!
            parsedBundle.totalTime = (bundle?.totalTime)!*/
        }
    }
    /*
    var parsedBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0.0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: [], preperations: [], ingredients: [:])*/
    
    var ref: FIRDatabaseReference!
    
    var bundleDetailHeader = SecondBundleDetailHeader()
    
    private let headerId = "headerId"
    private let TimePriceCellId = "TimePriceCellId"
    private let FunctionCellId = "FunctionCellId"
    private let RecipeCellId = "RecipeCellId"
    private let DescriptionCellId = "DescriptionCellId"
    
    func recieveDatafromDatabase() {
        /*self.ref.observe(.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    guard let restDict = rest.value as? [String: AnyObject] else {
                        continue
                    }
                    self.parsedBundle.ingredients = restDict["ingredients"] as! [String: [String]]
                }
            }
        })
        
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
                    print(item.imageName + " image name from firebase")
                    item.price = restDict["price"] as! Float
                    item.ingredients = restDict["ingredients"] as! [String: [String]]
                    item.steps = restDict["steps"] as! [[String]]
                    item.tag = restDict["tag"] as! [String]
                    item.name = restDict["name"] as! String
                    print(item.name + " name from firebase")
                    self.parsedBundle.recipes.append(item)
                    
                }
            }
            
        })*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uid2 = FIRAuth.auth()?.currentUser?.uid
        ref = FIRDatabase.database().reference().child("user").child(uid2!)
        
        sleep(1)
        recieveDatafromDatabase()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(SecondBundleDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(TimePriceCell.self, forCellWithReuseIdentifier: TimePriceCellId)
        collectionView?.register(SecondFunctionCell.self, forCellWithReuseIdentifier: FunctionCellId)
        collectionView?.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCellId)
    }
    
    
    func ShowShoppingList(bundle: Bundles) {
        
        let shoppingListController = ShoppingListController()
        shoppingListController.bundle = self.bundle
        navigationController?.pushViewController(shoppingListController, animated: true)
    }
    
    func ShowPreparation(bundle: Bundles) {
        
        let layout = UICollectionViewFlowLayout()
        
        let preparationController = PreparationController(collectionViewLayout: layout)
        preparationController.bundle = self.bundle
        
        navigationController?.pushViewController(preparationController, animated: true)
    }
    
    func ShowRecipe(bundle: Bundles) {
        
        let layout = UICollectionViewFlowLayout()
        
        let recipeController = RecipeController(collectionViewLayout: layout)
        recipeController.bundle = self.bundle
        
        navigationController?.pushViewController(recipeController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width:view.frame.width, height:110)
        case 1:
            return CGSize(width: view.frame.width, height: 100)
        case 2:
            return CGSize(width:view.frame.width, height:400)
            
        default:
            return CGSize(width:view.frame.width, height:200)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimePriceCellId, for: indexPath) as! TimePriceCell
            cell.bundle = self.bundle
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FunctionCellId, for: indexPath) as! SecondFunctionCell
            cell.bundle = self.bundle
            cell.bundleDetailController = self

            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCellId, for: indexPath) as! RecipeCell
            cell.bundle = self.bundle
            return cell
            
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: TimePriceCellId, for: indexPath) as! TimePriceCell
        }
    }
    
    
    //set header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:view.frame.width, height:200)
    }
    
    //deque header cell
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SecondBundleDetailHeader
        header.bundle = self.bundle
        return header
    }
    
}

class SecondBundleDetailHeader: BaseCell{
    
    let cellId = "bannerCellId"
    
    var bundle: Bundles? {
        didSet {
            if let imageName = bundle?.imageName {
                imageView.image = UIImage(named: imageName)
                imageView.clipsToBounds = true
            }
            bundleLabel.text = bundle?.name
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        //addSubview(segmentedControl)
        addSubview(bundleLabel)
        
        //bundleLabel.centerXAnchor.constraint(equalTo: bundleLabel.superview!.centerXAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        addConstraintsWithFormat(format: "V:|-100-[v0(40)]", views: bundleLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: bundleLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(200)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
    }
    
    
    let bundleLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor(white: 1, alpha: 0.8)
        label.textAlignment = NSTextAlignment.center
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30)
        label.numberOfLines = 2
        return label
    }()
    
}



