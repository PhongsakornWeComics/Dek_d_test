//
//  Meta.swift
//  Dek_D_Test
//
//  Created by Phongsakorn Srikate on 30/10/2566 BE.
//

import Foundation
class Meta: NSObject {
    var currentPage: Int?
    var totalItems: Int?
    var itemsPerPage: Int?
    var hasPrevious: Bool?
    var hasNext: Bool?
    
    init(dictionary: [String : Any]) {
        currentPage = dictionary["current_page"] as? Int
        totalItems = dictionary["total_items"] as? Int
        itemsPerPage = dictionary["items_per_page"] as? Int
        hasPrevious = dictionary["has_previous"] as? Bool
        hasNext = dictionary["has_next"] as? Bool
    }
}
