//
//  RatesDetailUIView.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class RatesDetailUIView: UIView {
	
	var ratesConvertedModel : [RatesConvertedModel]!
	var parentView : UIViewController!
	override init(frame: CGRect) {
		super.init(frame: frame)
					setupViews()
		      ratesConvertedModel = []
   	}
	
	init(frame: CGRect = .zero,
			 parentView: UIViewController,
			 model : [RatesConvertedModel]) {
		      super.init(frame: frame)
		      setupViews()
		      self.ratesConvertedModel = model
					self.parentView = parentView
		      ratesDetailTableView.items = ratesConvertedModel
	   }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	 }
	
	func setupViews(){
	  backgroundColor = .white
		translatesAutoresizingMaskIntoConstraints = false
		addSubview(ratesDetailTableViewHeader)
		addSubview(ratesDetailTableView)
		
		ratesDetailTableViewHeader.constrainTopOfSuperView(on: self,leadingConstant: 20,trailingConstant: -20)
		ratesDetailTableViewHeader.heightAnchor.constraint(equalToConstant: 50).isActive = true
		ratesDetailTableView.constrainBelowSuperViewsTopView(superview: self,
																												 below: ratesDetailTableViewHeader,spacing: 0)
		
	}
	
	lazy var ratesDetailTableView : GenericTableView<RatesConvertedModel, RateDifferenceTableViewCell> = {
		let data : [RatesConvertedModel] = []
		let tableview = GenericTableView.init(items: data, configure: { (cell : RateDifferenceTableViewCell, rate) in
		   	cell.monthValueLabel.text = rate.date
		  	cell.rateValueLabel.text = rate.rate.description
		  	cell.formattedRateValueLabel.text = rate.formattedConvertedValue
		},selectHandler: { (rate, cell) in
			
		})
		return tableview
	}()
	
	 var ratesDetailTableViewHeader : UIView = {
		    let header = UIView()
		        header.translatesAutoresizingMaskIntoConstraints = false
	      let monthLabel = UILabel()
		        monthLabel.translatesAutoresizingMaskIntoConstraints = false
		        monthLabel.text = "Date"
		        monthLabel.textAlignment = .left
	    	let rateLabel = UILabel()
		        rateLabel.translatesAutoresizingMaskIntoConstraints = false
		        rateLabel.text = "Exchane Rate"
		        rateLabel.textAlignment = .center
		        rateLabel.numberOfLines = 0
				let formatedRate = UILabel()
		        formatedRate.translatesAutoresizingMaskIntoConstraints = false
		        formatedRate.text = "Change %"
						formatedRate.textAlignment = .right
		    let stackView = UIStackView()
		        stackView.translatesAutoresizingMaskIntoConstraints = false
		        stackView.addArrangedSubview(monthLabel)
		        stackView.addArrangedSubview(rateLabel)
	    	    stackView.addArrangedSubview(formatedRate)
		        stackView.distribution = .fillEqually
            stackView.axis = .horizontal
				    header.addSubview(stackView)
		        stackView.constrainToSuperView(on: header)
		        header.addBottomBorder(color: UIColor(red: 0.8588, green: 0.8588, blue: 0.8588, alpha: 1.0), width: header.frame.width)
		return header
	}()
	
	
}
