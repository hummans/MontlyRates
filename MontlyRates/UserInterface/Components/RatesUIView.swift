//
//  RatesUIView.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

protocol RatesUIViewProtocol {
	func ratesTableViewSelected(rate: RatesModel,cell : RateTableViewCell)
}

class RatesUIView: UIView {
	
	var _parentView : UIViewController!
	
	var ratesProtocol : RatesUIViewProtocol!
	
	var _model : RatesViewModel!
	
	private var sorted: Bool = false
	
	var ratesData : [RatesModel]?{
		willSet{
			if newValue?.count == 0 {
				ratesTableView.items =  _model.cachedRatesModel ?? []
			}else{
				ratesTableView.items = newValue ?? []
			}
		}
		didSet{
		 	ratesTableView.fancyReload()
				}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(frame: CGRect = .zero,parentView:UIViewController,model : RatesViewModel) {
       super.init(frame: frame)
				 setupViews()
	      _model = model
	      _model.delegate = self
	      _parentView = parentView
  }
	
	func setupViews(){
		translatesAutoresizingMaskIntoConstraints = false 
		addSubview(ratesTableView)
		ratesTableView.constrainToSuperView(on: self)
		
	}
	
	lazy var ratesTableView : GenericTableView<RatesModel, RateTableViewCell> = {
		let data : [RatesModel] = []
		let tableview = GenericTableView.init(items: data, configure: { (cell : RateTableViewCell, rate) in
			cell.currencyCountryUIImage.image = rate.flagIconName.flagImage
			cell.currencyUILabel.text = rate.code
			cell.currencyCountryNameUILabel.text = rate.countryName
		},selectHandler: { (rate, cell) in
      guard let delegate = self.ratesProtocol else { return  }
			delegate.ratesTableViewSelected(rate: rate, cell: cell)
		})
		return tableview
	}()
	
}

extension RatesUIView {
	func populate(){
		guard let model = self._model else { return  }
		model.fetchRates()
	}
	func filterRates(searchText: String){
	  	ratesData = _model.cachedRatesModel?.filter{$0.code.lowercased().contains(searchText.lowercased()) ||
			$0.countryName.lowercased().contains(searchText.lowercased()) }
	}
	func sortRates(){
		 self.sorted = !self.sorted
	  	ratesData = self.sorted ? _model.cachedRatesModel?.sorted{ $0.code < $1.code } : _model.cachedRatesModel?.sorted{ $0.code > $1.code }
	}
}

extension RatesUIView : RatesViewModelProtocol{
	func fetchRatesBegan() {
	}
	func fetchRatesFailed(error: String, cachedData: [RatesModel]) {
		 ratesData = cachedData
		if cachedData.count > 0 {
			 _parentView.showBanner(title: "Offline mode", message: "Loaded from Cache", type: .warning)
		}else{
			 _parentView.showBanner(title: "Error", message: "Failed to load rates ", type: .error)
		}
	}
	func fetchRatesSuccess(rates: [RatesModel]) {
	    	ratesData = rates
	}
}


