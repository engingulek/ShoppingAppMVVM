//
//  ProductTableViewCell.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 15.05.2022.
//

import Foundation
import UIKit


protocol ProductCollectinViewCellDelegate {
    func addProduct(indexPath:Int)
}


class ProductCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var addCartButton : UIButton!
    @IBOutlet weak var productNameLabel : UILabel!
    @IBOutlet weak var productPriceLabel : UILabel!
    @IBOutlet weak var productGenderLabel : UILabel!
    
    var delegate : ProductCollectinViewCellDelegate?
    var indexPathRow : Int?
    
    
  
    
    
    @IBAction func addCartButtonAction(_ sender: Any) {
        delegate?.addProduct(indexPath: indexPathRow!)
    }
    
   
    
    
  

    
    
    
}
