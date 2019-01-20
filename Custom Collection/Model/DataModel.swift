//
//  DataModel.swift
//  Custom Collection
//
//  Created by Wang, Zewen on 2019-01-18.
//  Copyright © 2019 Wang, Zewen. All rights reserved.
//

import Foundation
class DataModel{
    static let instance = DataModel()
    var id:String = ""
    var title:String = ""
    var url:String = ""
    
    func setValue(id:String,title:String,url:String){
        self.id = id
        self.title = title
        self.url = url
    }
//    var aerodynamic:String = ""
//    var durable:String = ""
//    var small:String = ""
//
//    init(aerodynamic:String, durable:String,small:String){
//        self.aerodynamic = aerodynamic
//        self.durable = durable
//        self.small = small
//    }

}

