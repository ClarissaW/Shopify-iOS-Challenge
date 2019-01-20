//
//  CollectionDetailsVC.swift
//  Custom Collection
//
//  Created by Wang, Zewen on 2019-01-18.
//  Copyright © 2019 Wang, Zewen. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD
class CollectionDetailsVC: UITableViewController {
    var titleValue: String?  // Collection Name
    let crawl = CrawlData()
    var url:String?
    let font:UIFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0)!
    var json:JSON? // To receive the value passed from segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "detailCellIdentifier")
        
        self.navigationItem.title = titleValue
        
        
        navigationController?.navigationBar.tintColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        self.navigationController!.navigationBar.topItem!.title = ""
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return json!["products"].count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailCellIdentifier", for: indexPath) as! DetailTableViewCell
        setUIForCell(cell:cell)

        
        cell.productID.text = "ID: " + json!["products"][indexPath.section]["id"].stringValue
        cell.productName.text = json!["products"][indexPath.section]["title"].string!
//        cell.textLabel?.text = json!["products"][indexPath.row]["title"].string
        cell.title.text = "Product Type: " + json!["products"][indexPath.section]["product_type"].string!
        cell.publishTime.text = "Published At: " + json!["products"][indexPath.section]["published_at"].string!
        cell.vendors.text = "Vendors: " + json!["products"][indexPath.section]["vendor"].string!
        cell.tags.text = "Tags: \(json!["products"][indexPath.section]["tags"].stringValue)"
        cell.bodyHtml.text = "Body HTML: \(json!["products"][indexPath.section]["body_html"].stringValue)"
        
        var variants = json!["products"][indexPath.section]["variants"]
        var text = "Inventory Variants: \n \(getAllVariants(variants: variants))"
        cell.inventoryVariants.text = text
        let data = loadImage(url:json!["products"][indexPath.section]["image"]["src"].string!)
        cell.collectionImage.image = UIImage(data: data)
        
        return cell
    }
    
    
    func setUIForCell(cell:DetailTableViewCell){
        // Set Font
        cell.productID.font = font
        cell.productName.font = font
        cell.vendors.font = font
        cell.productName.font = font
        cell.productID.font = font
        cell.publishTime.font = font
        cell.title.font = font
        cell.bodyHtml.font = font
        
        // Set Image contentMode
        cell.collectionImage.contentMode = .scaleAspectFit
        
//        // ser Product name's content model
//        cell.productName.contentMode = .center
        
        // Set TableView Background and shape
        cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 4
        cell.layer.cornerRadius = 8
        cell.selectionStyle = .none
        
        // Set Numbers of lines for labels
        
        cell.inventoryVariants.lineBreakMode = .byWordWrapping
        cell.bodyHtml.numberOfLines = 0
        cell.title.numberOfLines = 0
        cell.vendors.numberOfLines = 0
        cell.publishTime.numberOfLines = 0
        cell.inventoryVariants.numberOfLines = 0

        
    }
    
    func loadImage(url:String)-> Data{
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        return data!
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let height:CGFloat = 10
        return height
    }
    
    func getAllVariants(variants:JSON)->String{
        var text = ""
        for num in 0..<variants.count{
            let image_id = variants[num]["image_id"].string
            let requires_shipping = variants[num]["requires_shipping"].stringValue
            let taxable = variants[num]["taxable"].stringValue
            let option2 =  variants[num]["option2"].string
            let position = variants[num]["position"].stringValue
            let sku = variants[num]["sku"].stringValue
            let barcode = variants[num]["barcode"].string
            let id = variants[num]["id"].stringValue
            let weight_unit = variants[num]["weight_unit"].stringValue
            let admin_graphql_api_id = variants[num]["admin_graphql_api_id"].string!
            let title = variants[num]["title"].stringValue
            let grams = variants[num]["grams"].stringValue
            let inventory_policy = variants[num]["inventory_policy"].string!
            let inventory_item_id = variants[num]["inventory_item_id"].stringValue
            let updated_at = variants[num]["updated_at"].string!
            let compare_at_price = variants[num]["compare_at_price"].string
            let inventory_quantity = variants[num]["inventory_quantity"].stringValue
            
            let price = variants[num]["price"].string!
            let option3 = variants[num]["option3"].string
            let product_id = variants[num]["product_id"].stringValue
            let created_at = variants[num]["created_at"].stringValue
            let option1 = variants[num]["option1"].string!
            let old_inventory_quantity = variants[num]["old_inventory_quantity"].stringValue
            let weight = variants[num]["weight"].stringValue
            let inventory_management = variants[num]["inventory_management"].string
            let fulfillment_service = variants[num]["fulfillment_service"].stringValue
            let variantsNum = String(num+1)
            
            text += "Variant \(variantsNum):\n Title: \(title)\n ID: \(id)\n Product ID: \(product_id)\n Option1: \(option1)\n Option2: \(option2)\n Option3: \(option3)\n Price: \(price)\n Compared at Price: \(compare_at_price)\n Inventory Quantity: \(inventory_quantity)\n Old Inventory Quantity: \(old_inventory_quantity)\n Inventory Management: \(inventory_management)\n Fullfillment Service: \(fulfillment_service)\n Requried Shipping: \(requires_shipping)\n Taxable: \(taxable)\n Inventory Policy: \(inventory_policy)\n Inventory Item ID: \(inventory_item_id)\n Position: \(position)\n SKU: \(sku)\n Barcode: \(barcode)\n Weight: \(weight)\n Weight Unit: \(weight_unit)\n Grams: \(grams)\n Image ID: \(image_id)\n Admin GraphQL API ID:\n    \(admin_graphql_api_id)\n Updated at: \(updated_at)\n Created at: \(created_at)  \n\n"
            
        }
        return text
    }
    

}
