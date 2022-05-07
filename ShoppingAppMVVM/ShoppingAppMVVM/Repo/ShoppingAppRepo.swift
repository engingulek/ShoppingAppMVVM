//
//  ShoppingAppRepo.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation

class ShoppingAppRepo {
    var webService : WebService!
    
    var categoryList : [Category]!
    
    func bringCategory() -> [Category] {
        return categoryList
    }
    
    func getAllCategoryFromDatabase(){
        WebService().dowloadCategory { list in
            if let categoryList = list {
                self.categoryList = categoryList
            }
        }
    }
}
