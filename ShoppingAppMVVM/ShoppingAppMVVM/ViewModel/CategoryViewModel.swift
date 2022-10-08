//
//  CategoryViewModel.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation


class CategoryListViewModel {
    var categoryList : [CategoryViewModel]
    init() {
        self.categoryList = [CategoryViewModel]()
    }

   func numberOfRowInSection()-> Int {
        
        return self.categoryList.count
    }
    
    
    func categoryAtIndex(_ index:Int) -> CategoryViewModel{
        return categoryList[index]
        
        
    }
    
 


    
    
}


struct CategoryViewModel {
    let category : Category
    
    var categoryName : String {
        return self.category.categoryName!
    }
    
    var categoryId : String {
        return self.category._id!
    }
}
