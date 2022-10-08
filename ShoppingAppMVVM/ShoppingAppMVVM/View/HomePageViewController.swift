//
//  ViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import UIKit
import Kingfisher

class HomePageViewController: UIViewController,CategoryDelegate {
 
    
    @IBOutlet weak var productCollectionView : UICollectionView!
    private var selectedCategory : CategoryViewModel? = nil
    
    @IBOutlet weak var filterCollectionView : UICollectionView!
    private var filterNameList = ["All","Woman","Man","Child","Unisex"]
    private var selectedFilterName : String? = nil
    private var selectedSortType : Bool? =  nil
    /// implement ProductListViewModel
    var productListViewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        setupUI()
        
        
       
        
        
    }
    
    @IBAction func sortTypeVisibility(_ sender: Any) {
        let sortTypeActionSheet = UIAlertController(title: "Sort Type", message: "Please Select an Sort Type", preferredStyle: .actionSheet)
        sortTypeActionSheet.addAction(UIAlertAction(title: "Price Growing", style: .default, handler: { (_) in
            self.selectedSortType = true
            //self.getData()
               }))

        sortTypeActionSheet.addAction(UIAlertAction(title: "Price Decreasing", style: .default, handler: { (_) in
            self.selectedSortType = false
          //  self.getData()
               }))

    
        sortTypeActionSheet.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { (_) in
            self.selectedSortType = nil
               }))
        
        self.present(sortTypeActionSheet, animated: true, completion: {
            print("completion block")
        })
    }
    
   
    private func getData() {
        WebService.webService.dowloadProducts { products in
            if let products = products {
                self.productListViewModel.productList = products.map(ProductViewModel.init)
                DispatchQueue.main.async {
                    self.productCollectionView.reloadData()
                }
            }
            
        }
    }
    
    /// fetchCategory
    /*private func getData() {
        WebService().dowloadProducts { products in
            
            if let products = products {
               
                
                if (self.selectedCategory != nil && self.selectedCategory?.categoryName != "Hepsi") {
                    let productList = products.filter{
                        $0.productCategory._id == self.selectedCategory?.categoryId
                    }
                    self.productListViewModel.productList = productList.map(ProductViewModel.init)
                }else if(self.selectedFilterName != nil && self.selectedFilterName != "All"){
                    let productList = products.filter{
                        $0.productGender == self.selectedFilterName
                    }
                    
                    self.productListViewModel.productList = productList.map(ProductViewModel.init)
                }else if (self.selectedSortType == true) {
                    let productList = products.sorted (by: {$0.productPrice < $1.productPrice})
                    
                    self.productListViewModel.productList = productList.map(ProductViewModel.init)
                }
                
                else if (self.selectedSortType == false) {
                    let productList = products.sorted (by: {$0.productPrice > $1.productPrice})
                    
                    self.productListViewModel.productList = productList.map(ProductViewModel.init)
                }
                
                else{
                    self.productListViewModel.productList = products.map(ProductViewModel.init)
                    
                }
                
                DispatchQueue.main.async {
                    self.productCollectionView.reloadData()
                    self.selectedSortType = nil
                    self.selectedFilterName = nil
                    self.selectedCategory = nil
                }
                
             
                
               
                
            }
        }
        
    }*/
  
    func selectedCategory(category: CategoryViewModel) {
        self.selectedCategory = category
       // getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController else
        {
            fatalError("nav error")
        }
        
        guard let homePageViewController = nav.viewControllers.first as? CategoriesViewController else {
            fatalError("ViewController not found")
        }
        
        homePageViewController.delegate = self
    }
}

///Category CollectionView
///  FilterList CollectionView
extension HomePageViewController:UICollectionViewDelegate,UICollectionViewDataSource,ProductCollectinViewCellDelegate{
    func addProduct(indexPath: IndexPath) {
        
    }
    
  
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productCollectionView {
            
            return self.productListViewModel.productList.count == 0 ? 0 : self.productListViewModel.productList.count
        }else{
            return filterNameList.count
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.productCollectionView   {
            let cell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
            
            let product = self.productListViewModel.cellForItemAt(indexPath.row)
            let url = URL(string: "\(product.productImgUrl)")
            cell.productImageView.kf.setImage(with: url)
            cell.productNameLabel.text = product.productName
            
            cell.productPriceLabel.text = "\(product.productPrice)"
            cell.productGenderLabel.text = product.productGender
            cell.indexPath = indexPath
            cell.delegate = self
            
           
            
            
            
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            cell.layer.cornerRadius = 10.0
            
            
            
          
            
            
           
            
            return cell
        }else if(collectionView == self.filterCollectionView){
            let cell = self.filterCollectionView.dequeueReusableCell(withReuseIdentifier: "filterNameCell", for: indexPath) as! FilterCollectionViewCell
        
            cell.filterName.text = filterNameList[indexPath.row]
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            cell.layer.cornerRadius = 10.0
           
            return cell
            
        }else{
            fatalError("Not collectionView")
        }
        
     
        
        
    }
    
    
    
    
 

  
    
    
    private func setupUI(){
        let design :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let widthPCV = self.productCollectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        
        let cellWidthPVC = (UIScreen.main.bounds.width-30)/2
        
        
        design.itemSize = CGSize(width: cellWidthPVC, height: 320)
        
       
        
        
       productCollectionView.collectionViewLayout = design
        
        
        let designFCV :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let widthFCV = self.filterCollectionView.frame.size.width
        let cellWidthFCV = (widthFCV-30)/3.5
        designFCV.itemSize = CGSize(width: cellWidthFCV, height: self.filterCollectionView.frame.size.height/2)
        designFCV.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
        
      
        
        designFCV.minimumInteritemSpacing = 20
        designFCV.minimumLineSpacing = 10
        designFCV.scrollDirection = .horizontal
 
        
       filterCollectionView.collectionViewLayout = designFCV
        
    }
    
    
    //collectionView cell didSelect
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.filterCollectionView {
            
            self.selectedFilterName = self.filterNameList[indexPath.row]
          //  getData()
            
        }else if (collectionView == self.productCollectionView) {
            
            
        
            
        }
        
        
        
        else{
            fatalError("Don't select collection view")
        }
    }
    
   /* func addProduct(indexPath: IndexPath) {
       
        
  
        let addProduct = self.productListViewModel.cellForItemAt(indexPath.row)
        
          let cartListUserId = "TestUserID"
        let category = Category(_id:addProduct.productCategory._id, categoryName: addProduct.productCategory.categoryName)
        let cartList = CartProductList(cartProductId: addProduct._id, cartProductName: addProduct.productName, cartProductPrice: addProduct.productPrice, cartProductCategory: category, cartProductImgUrl: addProduct.productImgUrl, cartProductPiece: addProduct.productPiece)
           
          
           
           WebService().addProducToCart(cartListUserId: cartListUserId, cartList: cartList) { result in
               if result == nil {
                   print("Error")
               }else{
                   print("Add Success")
               }
           }
    }*/
    
   
}




