//
//  ViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import UIKit
import Kingfisher

class HomePageViewController: UIViewController,CategoryDelegate {
 
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var productCollectionView : UICollectionView!
    private var selectedCategory : CategoryViewModel? = nil
    @IBOutlet weak var filterCollectionView : UICollectionView!
 
   
    /// implement ProductListViewModel
    var productListViewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        getData()
        
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        setupUI()
        
        super.viewDidLoad()
    }
    
    /// fetchCategory
    private func getData() {
        WebService().dowloadProducts { products in
            
            if let products = products {
               
                
                if (self.selectedCategory != nil && self.selectedCategory?.categoryName != "Hepsi") {
                    let productList = products.filter{
                        $0.productCategory._id == self.selectedCategory?.categoryId
                    }
                    self.productListViewModel.productList = productList.map(ProductViewModel.init)
                }else{
                    self.productListViewModel.productList = products.map(ProductViewModel.init)
                    
                }
                
                DispatchQueue.main.async {
                    self.productCollectionView.reloadData()
                }
                
             
                
               
                
            }
        }
        
    }
  
    func selectedCategory(category: CategoryViewModel) {
        categoryTitle.text = "\(category.categoryName)"
        self.selectedCategory = category
        getData()
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
extension HomePageViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productCollectionView {
            
            return self.productListViewModel.productList.count == 0 ? 0 : self.productListViewModel.productList.count
        }else{
            return 5
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.productCollectionView   {
            let cell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
            
            let product = self.productListViewModel.cellForItemAt(indexPath.row)
            let url = URL(string: "\(product.productImgUrl)")
            cell.productImageView.kf.setImage(with: url)
            cell.productNameLabel.text = product.productName
            cell.productPriceLabel.text = "\(product.productPrice) ₺"
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            cell.layer.cornerRadius = 10.0
           
            
            return cell
        }else{
            let cell = self.filterCollectionView.dequeueReusableCell(withReuseIdentifier: "filterNameCell", for: indexPath) as! FilterCollectionViewCell
            
       
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            cell.layer.cornerRadius = 10.0
            return cell
            
        }
        
     
        
        
    }
    
    
    private func setupUI(){
        let design :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let widthPCV = self.productCollectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellWidthPVC = (widthPCV-30)/2
        
        design.itemSize = CGSize(width: cellWidthPVC, height: cellWidthPVC*1.7)
        
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        productCollectionView.collectionViewLayout = design
        
        
        let designFCV :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let widthFCV = self.filterCollectionView.frame.size.width
        let cellWidthFCV = (widthFCV-30)/3
        designFCV.itemSize = CGSize(width: cellWidthFCV, height: self.filterCollectionView.frame.size.height/1.5)
        designFCV.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
        
      
        
        designFCV.minimumInteritemSpacing = 20
        designFCV.minimumLineSpacing = 10
        designFCV.scrollDirection = .horizontal
 
        
       filterCollectionView.collectionViewLayout = designFCV
        
      
        
        
        
    }
    
}




