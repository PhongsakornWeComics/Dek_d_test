//
//  ItemBannerCVCell.swift
//  Dek_D_Test
//
//  Created by Phongsakorn Srikate on 31/10/2566 BE.
//

import UIKit
import AlamofireImage

class ItemBannerCVCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView! {
        didSet {
            bannerImageView.layer.cornerRadius = 15
        }
    }
       
    var bannerList: BannerList! {
        didSet {
            if UIDevice.current.userInterfaceIdiom == .pad {
                if let imageUrlString = bannerList.imageUrl_tablet ,let imageURL = URL(string: imageUrlString) {
                    self.bannerImageView.af.setImage(withURL: imageURL, placeholderImage: nil, imageTransition: .crossDissolve(0.2))
                } else {
                    self.bannerImageView.image = UIImage(named: "")
                }
            } else {
                if let imageUrlString = bannerList.imageUrl_mobile ,let imageURL = URL(string: imageUrlString) {
                    self.bannerImageView.af.setImage(withURL: imageURL, placeholderImage: nil, imageTransition: .crossDissolve(0.2))
                } else {
                    self.bannerImageView.image = UIImage(named: "")
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
