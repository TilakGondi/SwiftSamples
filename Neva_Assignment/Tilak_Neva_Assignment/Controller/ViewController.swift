//
//  ViewController.swift
//  Tilak_Neva_Assignment
//
//  Created by Tilakkumar Gondi on 06/06/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var loading_lbl: UILabel!
    
    
    var profileData:[Profile]? {
        didSet{
            self.profileTable.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.profileTable.isHidden = true
        self.loading_lbl.isHidden = false
        APIHandler.sharedInstance.getProfileData {[unowned self] (profiles, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.profileTable.isHidden = false
                    self.loading_lbl.isHidden = true
                    self.profileData =  profiles?.removeDuplicates{($0.name ?? "")}
                }
            }
        }
    }
}



//Mark: TableView DataSource & Delegates
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProfileCell
        cell.profileData = profileData![indexPath.row] as Profile
        
        return cell
    }
    
    
}

//Mark: Helper Extensions
extension Array {
    func removeDuplicates<T:Hashable>(map: ((Element) -> (T))) -> [Element] {
        var obj = Set<T>()
        var uniqueArray = [Element]()
        for value in self{
            if !obj.contains(map(value))
            {
                obj.insert(map(value))
                uniqueArray.append(value)
            }
        }
        return uniqueArray
    }
}


