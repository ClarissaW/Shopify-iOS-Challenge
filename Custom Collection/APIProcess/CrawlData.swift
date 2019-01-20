//
//  CrawlData.swifret
//  Custom Collection
//
//  Created by Wang, Zewen on 2019-01-18.
//  Copyright © 2019 Wang, Zewen. All rights reserved.
//

import Foundation
import Alamofire

import SwiftyJSON
class CrawlData{
    
    func getData(url:String, completionHandler:@escaping(JSON?,Error?)->()){
        Alamofire.request(url).responseString { (response) in
            if(response.result.isSuccess){
                do{
                    let json = try JSON(data: response.data!)
                    completionHandler(json,nil)
                }
                catch{
                    completionHandler(nil, error)
                }
            }
        }
    }
    
    // MARK: - Get all the products info of a collection
    func getCollectionDetail(url:String, title: String, completionHandler:@escaping(JSON?,Error?)->()){
        Alamofire.request(url).responseString { (response) in
            if(response.result.isSuccess){
                do{
                    let json = try JSON(data: response.data!)
                    var id:String = ""
                    for num in 0..<json["custom_collections"].count{
                        if (json["custom_collections"][num]["title"].string?.lowercased().contains(title.lowercased()))!{
                            id = json["custom_collections"][num]["id"].stringValue
                            var collectionURL = BASEURL + id + ACCESS_TOKEN
                            
                            //Get Collection page
                            self.getData(url: collectionURL, completionHandler: { (collectionJSON, error) in
                                if(error == nil){
                                    var product_ids:String = ""
                                    for num in 0..<(collectionJSON!["collects"]).count{
                                        product_ids += collectionJSON!["collects"][num]["product_id"].stringValue
                                        if (num != (collectionJSON!["collects"]).count-1){
                                            product_ids += ","
                                        }
                                    }
                                    
                                    var product_url = BASEURL_PRODUCTS + product_ids + ACCESS_TOKEN_PRODUCTS
                                    // Get All products Infor (in one page) for chosen collection
                                    self.getData(url: product_url, completionHandler: { (productJSON, error) in
                                        if(error == nil){
                                        
                                        completionHandler(productJSON,nil)
                                        }
                                        else{
                                            debugPrint(error)
                                        }
                                    })
                                    
                                }else{
                                    debugPrint(error)
                                }
                            })
                        }
                    }
                    
                    
                }
                catch{
                    completionHandler(nil, error)
                    // serialized json response
                }
                
            }
        }
        
        
    }
    
    
    
    
}
