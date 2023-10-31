//
//  ViewController.swift
//  Dek_D_Test
//
//  Created by Phongsakorn Srikate on 29/10/2566 BE.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet  weak var tableView: UITableView!
    @IBOutlet  weak var titleLabel: UILabel! {
        didSet {
            if UIDevice.current.userInterfaceIdiom == .pad {
                titleLabel.textAlignment = .center
            }
        }
    }
    
    var novelList: [NovelList] = []
    var bannerList: [BannerList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
        requestListNovel()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ItemListNovelCell", bundle: nil), forCellReuseIdentifier: "ItemListNovelCell")
        tableView.register(UINib(nibName: "ItemBannerCell", bundle: nil), forCellReuseIdentifier: "ItemBannerCell")
            
    }
    
    private func setInfo() {
        self.title = "รายการนิยาย"
        
        
        // Create a view to represent the top safe area
        let topSafeAreaView = UIView()
        topSafeAreaView.backgroundColor = UIColor.blue // Set your desired background color
        view.addSubview(topSafeAreaView)

        // Constrain the top safe area view to the top of the safe area layout guide
        topSafeAreaView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSafeAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topSafeAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topSafeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSafeAreaView.bottomAnchor.constraint(equalTo: view.topAnchor)
        ])
    }

    private func requestListNovel() {
        var parameters = [String : Any]()
        parameters["page"] = 1
        Connection.request(api: .getListNovel, parameters: parameters) { data, meta  in
            guard let array = data as? [[String : Any]] else { return }
            self.novelList = array.map { NovelList(dictionary: $0)}
            self.requestListBanner()
        }
    }
    
    private func requestListBanner() {
        var parameters = [String : Any]()
        Connection.request(api: .getBanner) { data, meta  in
            guard let array = data as? [[String : Any]] else { return }
            self.bannerList = array.map { BannerList(dictionary: $0)}
            self.tableView.reloadData()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.novelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.novelList[indexPath.row].order ?? 0 > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListNovelCell", for: indexPath) as! ItemListNovelCell
            cell.novelList = self.novelList[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemBannerCell", for: indexPath) as! ItemBannerCell
            cell.bannerList = self.bannerList
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.novelList[indexPath.row].order ?? 0 > 0 {
            return 329
        } else {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 350
            } else {
                return 193
            }
                
        }
    }

}

