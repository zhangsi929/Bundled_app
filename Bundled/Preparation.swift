//
//  Preparation.swift
//  TabbarPages
//
//  Created by Wenqi Wang on 06/04/2017.
//  Copyright © 2017 SixSix. All rights reserved.
//

import UIKit

class Preparation: NSObject, NSCoding {
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("PrepInfoFile")
    
    var url: String
    var prepTime: Int
    var desc: String
    var imageName: String
    
    init(url: String, prepTime: Int, desc: String, imageName: String) {
        self.url = url
        self.prepTime = prepTime
        self.desc = desc
        self.imageName = imageName
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let url = aDecoder.decodeObject(forKey: "url") as? String ?? ""
        let prepTime = Int(aDecoder.decodeCInt(forKey: "prepTime"))
        let desc = aDecoder.decodeObject(forKey: "desc") as? String ?? ""
        let imageName = aDecoder.decodeObject(forKey: "imageName") as? String ?? ""
        self.init(url: url, prepTime: prepTime, desc: desc, imageName: imageName)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(url, forKey: "url")
        aCoder.encode(prepTime, forKey: "prepTime")
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(imageName, forKey: "imageName")
    }
    
    static func savePreperationInfo(_ prep: Preparation) -> Bool {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(prep, toFile: Preparation.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save info")
            return false
        } else {
            print("Info saved")
            return true
        }
    }
    
    // convert properties to dictionary type for easy upload to firebase
    func toAnyObject() -> Any {
        return [
            "url": url,
            "prepTime": prepTime,
            "desc": desc,
            "imageName": imageName
        ]
    }
}
