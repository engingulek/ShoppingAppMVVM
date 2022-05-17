//
//  CartProductList.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation

struct CartProductList : Codable{
   var cartProductId:String
   var cartproductName :String
   var cartproductPrice : Int
   var cartproductCategory: Category
   var cartproductImgUrl:String
   var cartproductPiece :Int
    
}
