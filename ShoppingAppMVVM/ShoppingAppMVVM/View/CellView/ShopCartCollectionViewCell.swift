//
//  CollectionViewCell.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import UIKit

protocol ShopCartCollectionViewCellDelegete {
    func deleteProductFromShopCart(indexPath:IndexPath)
}

class ShopCartCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shopCartProductImageVew: UIImageView!
    
    @IBOutlet weak var shopCartProductName: UILabel!
    
    @IBOutlet weak var shopCartProductPrice: UILabel!
    
    @IBOutlet weak var shopCartProductCategory: UILabel!
    
    @IBOutlet weak var shopCartProductPiece: UILabel!
    var delegate : ShopCartCollectionViewCellDelegete?
    var indexPath:IndexPath?
    
    
    @IBAction func deleteProductToCartAction(_ sender: Any) {
        delegate?.deleteProductFromShopCart(indexPath: indexPath!)
    }
    
}
