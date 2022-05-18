//
//  CartProductList.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation

struct CartProductList : Codable{
   var cartProductId:String
   var cartProductName :String
   var cartProductPrice : Int
   var cartProductCategory: Category
   var cartProductImgUrl:String
   var cartProductPiece :Int
    
}
