//
//  CartListListViewModel.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation


struct CartListResultViewModel {
    var cartListResult : [CartListViewModel]
    
    init(){
        self.cartListResult = [CartListViewModel]()
    }
    
    
   
    
    
    
    
   
}



struct CartListViewModel {
    var cartList : CartList
    
    var _id:String {
       return cartList._id
    }
    var cartListUserId:String {
      return  cartList.cartListUserId
    }
    var cartProductList:[CartProductList] {
        return cartList.cartList
    }
}




struct CartProductListViewModel {
    var cartProductList : [CartProductList]
    init(){
        self.cartProductList = [CartProductList]()
    }
    
    func cartProductListCount() -> Int{
        return self.cartProductList.count
    }
    
    func cellRowAt(index:Int) -> CartProductViewModel {
        return CartProductViewModel(cartProductList: self.cartProductList[index])
    }
    
}



struct CartProductViewModel{
    var cartProductList : CartProductList
    
    
    
    
    var cartProductId:String {
        return cartProductList.cartProductId
    }
    var cartProductName :String{
        return cartProductList.cartProductName
    }
    var cartProductPrice : Int {
        return cartProductList.cartProductPiece
    }
    var cartProductCategory: Category {
        return cartProductList.cartProductCategory
    }
    
    var cartProductImgUrl:String{
        return cartProductList.cartProductImgUrl
    }
    var cartProductPiece :Int{
        return cartProductList.cartProductPiece
    }
}




