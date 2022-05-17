//
//  CartListListViewModel.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation

class CartListListViewModel {
    var cartListListViewModel : [CartListViewModel]
    
    init(){
        self.cartListListViewModel = [CartListViewModel]()
    }
    
    func cartProductList()-> [CartProductList] {
        return self.cartListListViewModel[0].cartsList
    }
    
}





struct CartListViewModel {
    var cartList : CartList
    
    
    var cartListId:String {
        return cartList._id
    }
    var cartListUserIdId:String {
        return cartList.cartListUserId
    }
    
    var cartsList:[CartProductList] {
        return self.cartList.cartList
    }
}


class CartProductListListViewModel {
    var cartProdutListListViewModel : [CartProductListViewModel]
    init(){
        self.cartProdutListListViewModel = [CartProductListViewModel]()
    }
    
    func numberOfRowSection()->Int {
        return self.cartProdutListListViewModel.count
    }
    
    func cellRowAt(_ index:Int) -> CartProductListViewModel {
        return self.cartProdutListListViewModel[index]
    }
    
    
}

struct CartProductListViewModel {
    var cartProductList : CartProductList
    var cartProductId:String{
        return cartProductList.cartProductId
        
    }
    var cartproductName :String{
        return cartProductList.cartproductName
        
    }
    var cartproductPrice : Int{
        return cartProductList.cartproductPrice
        
    }
    var cartproductCategory: Category{
        return cartProductList.cartproductCategory
        
    }
    var cartproductImgUrl:String{
        return cartProductList.cartproductImgUrl
        
    }
    var cartproductPiece :Int{
        return cartProductList.cartproductPiece
        
    }
}
