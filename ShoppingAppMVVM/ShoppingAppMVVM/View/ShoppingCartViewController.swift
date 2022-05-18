//
//  ShoppingCartViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation
import UIKit



class ShoppingCartViewController : UIViewController,ShopCartCollectionViewCellDelegete{
    func deleteProductFromShopCart(indexPath: IndexPath) {
        print("Tıklandı")
        
    }
    
   
    @IBOutlet weak var shoppingCartCollectionView: UICollectionView!
    @IBOutlet weak var totalPriceUIView:UIView!

    
 
    
    /// implement CartListListViewModel
    /// Kullanıcının oluşturuduğu sepetin alınması için
 
    //var delegate : ShoppingCartViewControllerDelegete?
    var cartListResultViewModel = CartListResultViewModel()
    var cartProductListViewModel = CartProductListViewModel()
    /// Kullancının oluştruduğu sepetin içindeki ürünlerin alınması içi
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        shoppingCartCollectionView.delegate = self
        
        shoppingCartCollectionView.dataSource = self
      
        
        
        
    }
    
    
    func getData() {
        WebService().dowloadCartList { cartList in
            if let cartList = cartList {
                
                let checkUserIdFilter = cartList.filter{
                    $0.cartListUserId == "TestUserID"
                }
                
                // Zaten her kullanıcının bir tane olacağı için 0. indeks ile çağrılmıştır
               
                self.cartListResultViewModel.cartListResult = checkUserIdFilter.map(CartListViewModel.init)
                
                
              
                
              
              

                
                
               
                
                
                
                
                DispatchQueue.main.async {
                    self.cartProductListViewModel.cartProductList =
                    self.cartListResultViewModel.cartListResult[0].cartProductList
                   
                    
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
        print("Cell test \(self.cartProductListViewModel.cartProductListCount())")
        return  self.cartProductListViewModel.cartProductListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shoppingCartCollectionView.dequeueReusableCell(withReuseIdentifier: "shopCarCell", for: indexPath) as! ShopCartCollectionViewCell
        
        let cartProduct = self.cartProductListViewModel.cellRowAt(index: indexPath.row)
        print("Cell Item :\(cartProduct.cartProductName)")
       
        
       
        let imageUrl = URL(string: "\(cartProduct.cartProductImgUrl)")
        cell.shopCartProductImageVew.kf.setImage(with: imageUrl)
        cell.shopCartProductName.text = cartProduct.cartProductName
       cell.shopCartProductPiece.text = "\(cartProduct.cartProductPiece)"
        cell.shopCartProductPrice.text = "\(cartProduct.cartProductPrice)"
        cell.shopCartProductCategory.text = "\(cartProduct.cartProductCategory.categoryName)"
        cell.indexPath = indexPath
        cell.delegate = self
        
     
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10.0
        return cell
    }
    
    
}
