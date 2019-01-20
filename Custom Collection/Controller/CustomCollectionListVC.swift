//
//  CustomCollectionListVC.swift
//  Custom Collection
//
//  Created by Wang, Zewen on 2019-01-18.
//  Copyright © 2019 Wang, Zewen. All rights reserved.
//

import UIKit

import SwiftyJSON
import SVProgressHUD
class CustomCollectionListVC: UITableViewController {
    
    var collections_with_id = [String:Int]()
    var titleValue:String?
    var url:String?
    var json:JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 8
        tableView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title="Collections"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CCLidentifier", for: indexPath)
        cell.textLabel?.text = COLLECTIONS[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height:CGFloat = 6
        return height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail"){
            if let destVC = segue.destination as? CollectionDetailsVC{
                destVC.titleValue = titleValue
                destVC.json = json
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SVProgressHUD.show()
        titleValue = COLLECTIONS[indexPath.row]
        
        CrawlData().getCollectionDetail(url: FULLURL, title: titleValue!) { (jsonData, error) in
            
            if(error != nil){
                print(error)
            }else{
                self.json = jsonData
                
                self.performSegue(withIdentifier: "showDetail", sender: self)
                
            }
            

        }
        
    }
}
