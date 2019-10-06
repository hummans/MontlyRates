//
//  RateDifferenceTableViewCell.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class RateDifferenceTableViewCell: UITableViewCell {
	override func awakeFromNib() {
		super.awakeFromNib()
		configureSubviews()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		configureSubviews()
	}
	
	func configureSubviews(){
		labelsStack.addArrangedSubview(monthValueLabel)
		labelsStack.addArrangedSubview(rateValueLabel)
		labelsStack.addArrangedSubview(formattedRateValueLabel)
    addSubview(labelsStack)
		
		constrainViews()
		
	}
	
	func constrainViews(){
			 labelsStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
			 labelsStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
		   labelsStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
	}
	
	lazy var labelsStack: UIStackView = {
		let view = UIStackView()
		    view.axis = .horizontal
		    view.translatesAutoresizingMaskIntoConstraints = false
		    view.spacing = 1.0
		    view.distribution = UIStackView.Distribution.fillEqually
		return view
	}()
	
	lazy var monthValueLabel: UILabel = {
		let label = UILabel()
	    	label.translatesAutoresizingMaskIntoConstraints = false
		    label.font = regularFont
		    label.textColor = UIColor.lightGray
	      label.textAlignment = .left
		    label.text = "Month"
		return label
	}()
	
	lazy var rateValueLabel: UILabel = {
		let label = UILabel()
	    	label.translatesAutoresizingMaskIntoConstraints = false
	    	label.font = regularFont
	    	label.textColor = UIColor.lightGray
		    label.textAlignment = .center
		    label.text = "GHS"
		return label
	}()
	
	lazy var formattedRateValueLabel: UILabel = {
		let label = UILabel()
		    label.translatesAutoresizingMaskIntoConstraints = false
		    label.font = regularFont
		    label.textAlignment = .right
		    label.text = "Ghana Cedi"
		return label
	}()
	
	
}
