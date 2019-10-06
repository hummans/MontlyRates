//
//  CurrenciesViewController.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class RatesViewController: UIViewController {
	var ratesView : RatesUIView!
	var ratesVmodel : RatesViewModel!
	
  let searchController = UISearchController(searchResultsController: nil)
	
	override func viewDidLoad() {
			super.viewDidLoad()
      edgesForExtendedLayout = []
			setupUINavigationController()
		
		  ratesVmodel = RatesViewModel()
		  ratesView = RatesUIView(parentView: self,model: ratesVmodel)
		  ratesView.ratesProtocol = self
		
		///TODO Move to viewillAppear after test
		  ratesView.populate()

	}
	override func viewWillAppear(_ animated: Bool) {
		//ratesView.populate()
   }
	override func viewDidLayoutSubviews() {
		setUpSubViewsAndConstrainViews()
	  }
	
	func setupUINavigationController(){

		self.title = "Currency Rates"

		self.navigationItem.searchController = searchController
		searchController.searchBar.placeholder = "Search currencies"
		searchController.searchBar.delegate = self
		searchController.obscuresBackgroundDuringPresentation = false
		definesPresentationContext = true

		let sortedUIButton = UIBarButtonItem(image: #imageLiteral(resourceName: "sorter"), style: .plain, target: self, action:  #selector(sortAction))
		self.navigationController?.navigationBar.tintColor = .black
		self.navigationItem.rightBarButtonItem = sortedUIButton
		
	}
	func setUpSubViewsAndConstrainViews(){
		self.view.addSubview(ratesView)
		ratesView.constrainToSuperView(on: self.view)
	}
	
}

extension RatesViewController : RatesUIViewProtocol {
	func ratesTableViewSelected(rate: RatesModel, cell: RateTableViewCell) {
		let detailView = RatesDetailViewController()
		cell.progressIndicator.startAnimating()
		
		ratesVmodel.getPercentageDifference(forCurrency: rate.code) { (convertedRates,errors) in
		cell.progressIndicator.stopAnimating()
			if errors.count > 0 {
				 self.showBanner(title: "Error",
												 message: errors.first?.StringDescription ?? "An error occured",
												 type: .error)
			}else{
				detailView.convertedRates = convertedRates
				detailView.keyCurrency =  "EUR to \(rate.code.description)" 
				self.show(detailView, sender: self)
			}
		
		}
		
	
		
	}
}

extension RatesViewController : UISearchBarDelegate {
	@objc func sortAction(){
		    ratesView.sortRates()
	}
	func searchBar(_ searchBar: UISearchBar,
								 textDidChange searchText: String) {
		   ratesView.filterRates(searchText: searchText)
	}
}

