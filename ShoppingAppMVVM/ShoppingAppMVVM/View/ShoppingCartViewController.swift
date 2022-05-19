//
//  ShoppingCartViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation
import UIKit



class ShoppingCartViewController : UIViewController,ShopCartCollectionViewCellDelegete{
    
    
    
   
    @IBOutlet weak var shoppingCartCollectionView: UICollectionView!
    @IBOutlet weak var totalPriceUIView:UIView!

    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var amountResultLabel: UILabel!
    
   
    @IBOutlet weak var emptyShopCartLabel: UILabel!
    @IBOutlet weak var toOrderButton: UIButton!
    
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
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.totalPriceUIView.frame.size.width, height: 2.0)
        
           topBorder.backgroundColor = UIColor.red.cgColor
        
  
        
        self.totalPriceUIView.layer.addSublayer(topBorder)
        self.emptyShopCartLabel.isHidden = true
        
        
        
        
        
        
        
      
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    @IBAction func toOrderButtonAction(_ sender: Any) {
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
                    self.amountResultLabel.text = "\(self.cartProductListViewModel.calculateAmount()) ₺"
                   
                    if self.cartProductListViewModel.cartProductListCount() == 0 {
                        self.shoppingCartCollectionView.isHidden = true
                        self.amountLabel.isHidden = true
                        self.amountResultLabel.isHidden = true
                        self.totalPriceUIView.isHidden = true
                        self.emptyShopCartLabel.isHidden = false
                    }else{
                        self.shoppingCartCollectionView.isHidden = false
                        self.amountLabel.isHidden = false
                        self.amountResultLabel.isHidden = false
                        self.totalPriceUIView.isHidden = false
                        self.emptyShopCartLabel.isHidden = true
                    }
                    
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
    
    
    
    func incAndDecPieceAction(indexPath: IndexPath, type: String) {
        let cartProductId = self.cartProductListViewModel.cellRowAt(index: indexPath.row).cartProductId
        let defaultUserId = "TestUserID"
        print("Product Id : \(cartProductId)")
        WebService().incrementAndDecrementAction(type: type, userId: defaultUserId, cartProductId: cartProductId) { result in
            if result != nil{
                print("Success")
                self.getData()
            }else{
                print("Error")
            }
        }
        
        
    }
    
    
    
    func deleteProductFromShopCart(indexPath: IndexPath) {
        let cartProductId = self.cartProductListViewModel.cellRowAt(index: indexPath.row).cartProductId
        let defaultUserId = "TestUserID"
        
        WebService().deleteProduct(userId: defaultUserId, cartProductId: cartProductId) { result in
            if result != nil{
                print("Success")
                self.getData()
            }else{
                print("Error")
            }
        }
     
        print("Product Id : \(cartProductId)")
        
    }
    
    
    
    
    
}
