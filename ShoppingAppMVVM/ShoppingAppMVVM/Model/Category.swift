//
//  Category.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation

class Category : Codable {
    var _id:String?
    var categoryName:String?
    
    init(_id:String?,categoryName:String?){
        self._id = _id
        self.categoryName = categoryName
        
    }
}
