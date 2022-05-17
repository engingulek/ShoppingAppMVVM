//
//  ShoppingCartViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation
import UIKit

protocol ShoppingCartViewControllerDelegete {
    func getCartProductList(cartProductListListVM:CartProductListListViewModel)
}

class ShoppingCartViewController : UIViewController,ShopCartCollectionViewCellDelegete{
    func deleteProductFromShopCart(indexPath: IndexPath) {
        print("Tıklandı")
        
    }
    
   
    @IBOutlet weak var shoppingCartCollectionView: UICollectionView!
    @IBOutlet weak var totalPriceUIView:UIView!

    
 
    
    /// implement CartListListViewModel
    /// Kullanıcının oluşturuduğu sepetin alınması için
    var cartListListViewModel = CartListListViewModel()
    var delegate : ShoppingCartViewControllerDelegete?
    
    /// Kullancının oluştruduğu sepetin içindeki ürünlerin alınması içi
    var cartProductListListViewModel = CartProductListListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        shoppingCartCollectionView.delegate = self
        
        shoppingCartCollectionView.dataSource = self
      
        
        
        
    }
    
    
    func getData() {
        WebService().dowloadCartList(cartListUserId: "TestUserID") { cartList in
            if let cartList = cartList {
                self.cartListListViewModel.cartListListViewModel = cartList.map(CartListViewModel.init)
                DispatchQueue.main.async {
                    self.cartProductListListViewModel.cartProdutListListViewModel =
                    self.cartListListViewModel.cartProductList().map(CartProductListViewModel.init)
                    print(self.cartProductListListViewModel.numberOfRowSection())
                    self.shoppingCartCollectionView.reloadData()
                 
                    
                    
                
                }
                
                
            }
        }
        
    }
    
    
    func uıSetup(){
        
        totalPriceUIView.layer.borderWidth = 1
        totalPriceUIView.layer.cornerRadius = 10
        totalPriceUIView.layer.borderColor = UIColor.red.cgColor
        
        let design :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let widthPCV = self.shoppingCartCollectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellWidthPVC = (widthPCV-30)/2
        
        design.itemSize = CGSize(width: cellWidthPVC, height: cellWidthPVC*1.7)
        
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        shoppingCartCollectionView.collectionViewLayout = design
        
    }
}

extension ShoppingCartViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cartProductListListViewModel.numberOfRowSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shoppingCartCollectionView.dequeueReusableCell(withReuseIdentifier: "shopCarCell", for: indexPath) as! ShopCartCollectionViewCell
        
        let cartProduct = self.cartProductListListViewModel.cellRowAt(indexPath.row)
        let imageUrl = URL(string: "\(cartProduct.cartproductImgUrl)")
        cell.shopCartProductImageVew.kf.setImage(with: imageUrl)
        cell.shopCartProductName.text = cartProduct.cartproductName
        cell.shopCartProductPiece.text = "\(cartProduct.cartproductPiece)"
        cell.shopCartProductPrice.text = "\(cartProduct.cartproductPrice)"
        cell.shopCartProductCategory.text = "\(cartProduct.cartproductCategory.categoryName)"
        cell.indexPath = indexPath
        cell.delegate = self
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10.0
        return cell
    }
    
    
}
