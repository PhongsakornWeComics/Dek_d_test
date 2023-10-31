//
//  ItemListNevelCell.swift
//  Dek_D_Test
//
//  Created by Phongsakorn Srikate on 29/10/2566 BE.
//

import UIKit
import AlamofireImage
import Foundation

class ItemListNovelCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var imgNovel: UIImageView! {
        didSet {
            self.imgNovel.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var lbNovelName: UILabel!
    @IBOutlet weak var lbNovelTitle: UILabel!
    @IBOutlet weak var lbNovelSubTitle: UILabel!
    @IBOutlet weak var lbNovelDesc: UILabel!
    @IBOutlet weak var subView: UIView! {
        didSet {
            self.subView.layer.cornerRadius = 10
            self.subView.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
            self.subView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var ratingView: UIView! {
        didSet {
            self.ratingView.layer.cornerRadius = 10
            self.ratingView.layer.borderColor = UIColor(red: 243/255, green: 122/255, blue: 1/255, alpha: 1).cgColor
            self.ratingView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var imgNovelOrder: UIImageView!
    @IBOutlet weak var lbNovelView: UILabel!
    @IBOutlet weak var lbNovelTotalChapter: UILabel!
    @IBOutlet weak var lbNovelComment: UILabel!
    @IBOutlet weak var lbNovelUpdateDate: UILabel!
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblUpdateAt: UILabel!
    
    var novelList: NovelList! {
        didSet {
            if let imageUrlString = novelList.thumbnailNormal ,let imageURL = URL(string: imageUrlString) {
                self.imgNovel.af.setImage(withURL: imageURL, placeholderImage: nil, imageTransition: .crossDissolve(0.2))
            } else {
                self.imgNovel.image = UIImage(named: "")
            }
            
            self.lbNovelName.text = novelList.title
            self.lbNovelTitle.text = novelList.mainTitle
            self.lbNovelSubTitle.text = novelList.subTitle
            self.lblRating.text = String(NumberFormatter.formatNumber(novelList.order ?? 0))
            self.lbNovelDesc.text = novelList.detail
            self.lbNovelTotalChapter.text = String(NumberFormatter.formatNumber(novelList.totalChapter ?? 0))
            self.lbNovelView.text = String(NumberFormatter.formatNumber(novelList.view ?? 0))
            self.lbNovelComment.text = String(NumberFormatter.formatNumber(novelList.comment ?? 0))
            
            switch novelList.order {
            case 1:
                self.imgNovelOrder.image = UIImage(named: "ic_crown_1")
                self.imgNovelOrder.isHidden = false
            case 2:
                self.imgNovelOrder.image = UIImage(named: "ic_crown_2")
                self.imgNovelOrder.isHidden = false
            case 3:
                self.imgNovelOrder.image = UIImage(named: "ic_crown_3")
                self.imgNovelOrder.isHidden = false
            default:
                self.imgNovelOrder.isHidden = true
            }
            
            let dateString = novelList.updateAt ?? "0000-00-00 00:00:00"
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let date = inputFormatter.date(from: dateString)

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yy / HH:mm น."
            outputFormatter.locale = Locale(identifier: "th_TH")

            
            if let formattedDate = date.map(outputFormatter.string) {
                self.lblUpdateAt.text = "อัพเดทล่าสุด \(formattedDate)"
                
                print(formattedDate)
            } else {
                // Date parsing failed
                print("Date parsing failed")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCV.delegate = self
        categoryCV.dataSource = self
        categoryCV.register(UINib(nibName: "ItemTypeCell", bundle: nil), forCellWithReuseIdentifier: "ItemTypeCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.novelList.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemTypeCell", for: indexPath) as! ItemTypeCell
        cell.titleLabel.text = "#" + self.novelList.tags[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = self.novelList.tags[indexPath.row]
        let width = calculateWidthForText(text)
        let height = 26.0
        
        return CGSize(width: width, height: height)
    }
    
    private func calculateWidthForText(_ text: String) -> CGFloat {
           let font = UIFont.systemFont(ofSize: 17.0)
           let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]

           let textSize = (text as NSString).size(withAttributes: textAttributes)
           let padding: CGFloat = 16.0

           return textSize.width + padding
       }
}

class NumberFormatter {
    static func formatNumber(_ number: Int) -> String {
        let numberFormatter = Foundation.NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) {
            return formattedNumber
        }
        return ""
    }
}
