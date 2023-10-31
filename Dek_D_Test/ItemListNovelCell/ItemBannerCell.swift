//
//  ItemBannerCell.swift
//  Dek_D_Test
//
//  Created by Phongsakorn Srikate on 31/10/2566 BE.
//

import UIKit

class ItemBannerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var heightBannerCollectionView: NSLayoutConstraint! {
        didSet {
            if UIDevice.current.userInterfaceIdiom == .pad {
                heightBannerCollectionView.constant = 300
            }
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    var currentIndex: Int = 0
    var timer: Timer?
    var bannerList: [BannerList] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.register(UINib(nibName: "ItemBannerCVCell", bundle: nil), forCellWithReuseIdentifier: "ItemBannerCVCell")
        startAutoScroll()
    }
    
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        currentIndex = (currentIndex + 1) % bannerList.count
        bannerCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
         pageControl.currentPage = currentIndex
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemBannerCVCell", for: indexPath) as! ItemBannerCVCell
        cell.bannerList = self.bannerList[indexPath.item]
        pageControl.numberOfPages = bannerCollectionView.numberOfItems(inSection: 0)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        if UIDevice.current.userInterfaceIdiom == .pad {
            let height = 350.0
            return CGSize(width: width, height: height)
        } else {
            let height = 193.0
            return CGSize(width: width, height: height)
        }
    }
    
}
