//
//  NovelList.swift
//  Dek_D_Test
//
//  Created by Phongsakorn Srikate on 30/10/2566 BE.
//

import Foundation
class NovelList: NSObject {
    var id: Int?
    var title: String?
    var type: String?
    var detail: String?
    var updateAt: String?
    var order: Int?
    var mainTitle: String?
    var subTitle: String?
    var view: Int?
    var comment: Int?
    var totalChapter: Int?
    var thumbnailNormal: String?
    var tags: [String] = []
    
    init(dictionary: [String : Any]) {
        super.init()
        if let novelDict = dictionary["novel"] as? [String : Any] {
            id = novelDict["id"] as? Int
            title = novelDict["title"] as? String
            type = novelDict["type"] as? String
            detail = novelDict["description"] as? String
            updateAt = novelDict["updatedAt"] as? String
            order = novelDict["order"] as? Int
            totalChapter = novelDict["totalChapter"] as? Int
            tags = novelDict["tags"] as? [String] ?? []
            
            if let categoryDict = novelDict["category"] as? [String : Any] {
                mainTitle = categoryDict["mainTitle"] as? String
                subTitle = categoryDict["subTitle"] as? String
            }
            
            if let thumbnailDict = novelDict["thumbnail"] as? [String : Any] {
                thumbnailNormal = thumbnailDict["normal"] as? String
            }
            
            if let engagementDict = novelDict["engagement"] as? [String : Any] {
                if let viewDict = engagementDict["view"] as? [String : Any] {
                    view = viewDict["overall"] as? Int
                    
                }
                
                if let commentDict = engagementDict["comment"] as? [String : Any] {
                    comment = commentDict["overall"] as? Int
                }
            }
        }
    }
}
