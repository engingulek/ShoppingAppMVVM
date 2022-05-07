//
//  CategoryViewModel.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation


struct CategoryListViewModel {
    let categoryList : [Category]
    
    
    func numberOfRowInSection()-> Int {
        return self.categoryList.count
    }
    
    
    func categoryAtIndex(_ index:Int) -> CategoryViewModel{
        let category = self.categoryList[index]
        return CategoryViewModel(category: category)
        
        
    }
}


struct CategoryViewModel {
    let category : Category
    
    var categoryName : String {
        return self.category.categoryName
    }
    
    var categoryId : String {
        return self.category._id
    }
}
