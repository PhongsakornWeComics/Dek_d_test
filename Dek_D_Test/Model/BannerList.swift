//
//  BannerList.swift
//  Dek_D_Test
//
//  Created by Phongsakorn Srikate on 31/10/2566 BE.
//

import Foundation
class BannerList: NSObject {
    var id: Int?
    var imageUrl_mobile: String?
    var imageUrl_tablet: String?
    
    init(dictionary: [String : Any]) {
        super.init()
        id = dictionary["id"] as? Int
        
        if let payloadDict = dictionary["payload"] as? [String : Any] {
            if let imageUrlDict = payloadDict["imageUrl"] as? [String : Any] {
                imageUrl_mobile = imageUrlDict["mobile"] as? String
                imageUrl_tablet = imageUrlDict["tablet"] as? String
            }
        }
    }
}
