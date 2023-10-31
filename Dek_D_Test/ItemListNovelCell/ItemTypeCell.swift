//
//  ItemTypeCell.swift
//  Dek_D_Test
//
//  Created by Phongsakorn Srikate on 31/10/2566 BE.
//

import UIKit

class ItemTypeCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.cornerRadius = 10
            bgView.layer.borderWidth = 1
            bgView.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
