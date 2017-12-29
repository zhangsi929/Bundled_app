//
//  ViewController.swift
//  AppStore
//
//  Created by Wenqi Wang on 24/03/2017.
//  Copyright © 2017 Wenqi Wang. All rights reserved.
//

import UIKit

class FeaturedBundlesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
// this is the page that shows all available bundles satisfying the requirements of user
    
    private let cellId = "cellId"
    private let largeCellId = "largeCellId"
    private let headerId = "headerId"
    
    var featuredBundles: FeaturedBundles?
    var bundleCategories: [BundleCategory]?
    var bannerCategory: BundleCategory?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bundles for You"
        featuredBundles = BundleCategory.sampleBundleCategories().first
        bundleCategories = featuredBundles?.bundleCategories
        bannerCategory = featuredBundles?.bannerCategory
        
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FeaturedBundlesController.goBack))
        navigationItem.leftBarButtonItem = backButton
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        
        //register header
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    
    //perform segues in code
    func showBundleDetailForBundle(bundle: Bundles) {
        let layout = UICollectionViewFlowLayout()
        let bundleDetailController = BundleDetailController(collectionViewLayout: layout)
        bundleDetailController.bundle = bundle
        navigationController?.pushViewController(bundleDetailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
            cell.bundleCategory = bundleCategories?[indexPath.item]
            cell.featuredBundlesController = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        
        cell.bundleCategory = bundleCategories?[indexPath.item]
        cell.featuredBundlesController = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = bundleCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 4 {
            return CGSize(width: view.frame.width, height: 160)
        }
        
        return CGSize(width: view.frame.width, height: 230)
    }
    
    //set header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:view.frame.width, height:200)
    }
    
    //deque header cell
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        
        header.featuredBundlesController = self
        header.bundleCategory = bannerCategory
        
        return header
    }
}

var featuredBundlesController = FeaturedBundlesController()

//define header class
class Header: CategoryCell {
    
    let cellId = "bannerCellId"
    
    override func setupViews() {
        //super.setupViews()
        
        bundlesCollectionView.dataSource = self
        bundlesCollectionView.delegate = self
        
        bundlesCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(bundlesCollectionView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":bundlesCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":bundlesCollectionView]))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BundleCell
        cell.bundle = bundleCategory?.bundles?[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let bundle = bundleCategory?.bundles?[indexPath.item] {
            featuredBundlesController?.showBundleDetailForBundle(bundle: bundle)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
        
    }
    
    public class BannerCell: BundleCell {
        //this cell is the one at the top of the page
        
        internal override func setupViews() {
            super.setupViews()
            imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
            imageView.layer.borderWidth = 0.5
            imageView.layer.cornerRadius = 10
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.lightGray
            addSubview(imageView)
            
            nameLabel.textColor = UIColor.black
            nameLabel.backgroundColor = UIColor(white: 1, alpha: 0.7)
            nameLabel.textAlignment = NSTextAlignment.center
            nameLabel.adjustsFontSizeToFitWidth = true
            nameLabel.textAlignment = .center
            nameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 40)
            nameLabel.numberOfLines = 2
            
            addSubview(nameLabel)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
            addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)
            addConstraintsWithFormat(format: "V:|-80-[v0(60)]", views: nameLabel)

        }
    }
    
}

class LargeCategoryCell: CategoryCell {
    //the cells in the category rows
    private let largeAppCellId = "largeAppCellId"
    
    override func setupViews() {
        super.setupViews()
        
        bundlesCollectionView.register(LargeBundleCell.self, forCellWithReuseIdentifier: "largeAppCellId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeAppCellId, for: indexPath) as! BundleCell
        cell.bundle = bundleCategory?.bundles?[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 32)
        
    }
    
    public class LargeBundleCell: BundleCell {
        
        internal override func setupViews() {
            super.setupViews()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.black
            addSubview(imageView)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
        }
    }
}








