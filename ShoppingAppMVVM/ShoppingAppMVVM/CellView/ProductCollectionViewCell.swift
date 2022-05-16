//
//  ProductTableViewCell.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 15.05.2022.
//

import Foundation
import UIKit

class ProductCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var addCartButton : UIButton!
    @IBOutlet weak var productNameLabel : UILabel!
    @IBOutlet weak var productPriceLabel : UILabel!
    @IBOutlet weak var productGenderLabel : UILabel!
    
}
