//
//  BaseCell.swift
//  Bundled
//
//  Created by Wenqi Wang on 11/04/2017.
//  Copyright © 2017 si zhang. All rights reserved.
//
import UIKit

//this the base cell that will be inherited by other cell to reduce redundant code.
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
