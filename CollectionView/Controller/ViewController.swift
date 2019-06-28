//
//  ViewController.swift
//  CollectionView
//
//  Created by Gorantla Meghana on 20/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    var responseProducts: [Products] = []
    @IBOutlet weak var collectionViewController: UICollectionView!
    var itemsPerPage = 24
    var pageNo = 0
    var searchTerm = ""
    let reuseIdentifier = "CollectionViewCell"
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 2.0, bottom: 50.0, right: 2.0)
    let blibliUrl = "https://www.blibli.com/backend/search/products"
    var itemsPerRow: CGFloat = 2
    var searchBool = true
    var spinner = UIActivityIndicatorView()
    let noDataLable = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewController.backgroundColor = UIColor.lightGray
        collectionViewController.dataSource = self
        collectionViewController.delegate = self
        collectionViewController.prefetchDataSource = self
        //For Cell created by xib
        //collectionViewController.register(ProductCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionViewController.register(ProgramaticProductCellCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        //Handling the case that productsList.count = 0
        collectionViewController.addSubview(noDataLable)
        noDataLable.text = "No Data Available"
        noDataLable.translatesAutoresizingMaskIntoConstraints = false
        noDataLable.centerXAnchor.constraint(equalTo: collectionViewController.centerXAnchor, constant: 0).isActive = true
        noDataLable.centerYAnchor.constraint(equalTo: collectionViewController.centerYAnchor, constant: 0).isActive = true
        noDataLable.isHidden = true
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewController.collectionViewLayout.invalidateLayout()
    }
    
    //Networking Calls
    func getProducts(params: [String : String]) {
        Alamofire.request(blibliUrl, method: .get, parameters: params).responseData { (productDataOptional) in
            guard let productData = productDataOptional.data else { return }
            if productDataOptional.error != nil {
                return
            }
            let productDataDecoder = JSONDecoder()
            do {
                let productDataFromDecoder = try productDataDecoder.decode(ProductDataModel.self, from: productData)
                guard let data = productDataFromDecoder.data else { self.dismissLoader(spinner: self.spinner); return }
                guard let products = data.products, products.count != 0 else { self.noDataLable.isHidden = false; self.dismissLoader(spinner: self.spinner); return }
                self.responseProducts.append(contentsOf: products)
                self.dismissLoader(spinner: self.spinner)
                //As reloading is a heavy process, just do insert items when new data is added
                if self.pageNo == 0 {
                    self.collectionViewController.reloadData()
                    self.collectionViewController.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                } else {
                    let insertIndexPaths = Array(self.responseProducts.count - products.count...self.responseProducts.count - 1).map { IndexPath(item: $0, section: 0) }
                    self.collectionViewController.insertItems(at: insertIndexPaths)
                }
                self.searchBool = true
                self.pageNo += 1
            }
            catch let err {
                print("Err \(err)")
            }
        }
    }
    
    //Activity Indicator
    func showLoader(view: UIView) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
        spinner.backgroundColor = UIColor.white
        spinner.style = UIActivityIndicatorView.Style.gray;
        
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        spinner.startAnimating()
        spinner.transform = CGAffineTransform(scaleX: 2, y: 2)
        //UIApplication.shared.beginIgnoringInteractionEvents() //UIApplication is a singleton object and can be accessed by using .shared. It is created by UIApplicationMain() function when app is launched
        return spinner
    }
    
    func dismissLoader(spinner: UIActivityIndicatorView) {
        spinner.stopAnimating()
        //UIApplication.shared.endIgnoringInteractionEvents()
    }
}

extension NSMutableAttributedString {
    
    func starWithRating(rating:Float, outOfTotal totalNumberOfStars:NSInteger, withFontSize size:CGFloat) ->NSAttributedString {
        guard let currentFont = UIFont(name: "Helvetica Neue", size: size) else { return NSAttributedString() }
        let activeStarFormat = [ NSAttributedString.Key.font:currentFont, NSAttributedString.Key.foregroundColor: UIColor(red:0.91, green:0.76, blue:0.38, alpha:1.0) ];
        let inactiveStarFormat = [ NSAttributedString.Key.font:currentFont, NSAttributedString.Key.foregroundColor: UIColor.lightGray];
        let starString = NSMutableAttributedString()
        for i in 0..<totalNumberOfStars {
            if(rating >= Float(i+1)) {
                starString.append(NSAttributedString(string: "\u{2605} ", attributes: activeStarFormat))
            }
            else if (rating > Float(i)) {
                starString.append(NSAttributedString(string: "\u{2B50} ", attributes: activeStarFormat))
            }
            else {
                starString.append(NSAttributedString(string: "\u{2606} ", attributes: inactiveStarFormat))
            }
        }
        return starString
    }
}

