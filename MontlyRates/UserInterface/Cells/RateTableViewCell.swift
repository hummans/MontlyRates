//
//  CurrencyTableViewCell.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
	
	
	override func awakeFromNib() {
			super.awakeFromNib()
			configureSubviews()
	  }
	override func setSelected(_ selected: Bool, animated: Bool) {
			super.setSelected(selected, animated: animated)
			configureSubviews()
	  }
	
	func configureSubviews(){
		addSubview(currencyCountryUIImage)
		addSubview(currencyUILabel)
		addSubview(currencyCountryNameUILabel)
		addSubview(progressIndicator)
		constrainViews()
		
	}
	func constrainViews(){
		currencyCountryUIImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15).isActive = true
		currencyCountryUIImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		currencyCountryUIImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
		currencyCountryUIImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
		
		currencyUILabel.leadingAnchor.constraint(equalTo: currencyCountryUIImage.trailingAnchor,constant: 20).isActive = true
		currencyUILabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		currencyUILabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
		
		currencyCountryNameUILabel.leadingAnchor.constraint(equalTo: currencyUILabel.trailingAnchor,constant: 12).isActive = true
		currencyCountryNameUILabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		
		progressIndicator.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
		progressIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		
	}
	
	lazy var progressIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .white)
	    	view.color = #colorLiteral(red: 0.2969530523, green: 0.2969608307, blue: 0.2969566584, alpha: 1)
	    	view.translatesAutoresizingMaskIntoConstraints = false
	    	view.hidesWhenStopped = true
	    	view.stopAnimating()
		return view
	}()
	
	lazy var currencyCountryUIImage: UIImageView = {
		let imageView = UIImageView()
		    imageView.contentMode = .scaleAspectFill
		    imageView.layer.cornerRadius = 20
		    imageView.layer.borderColor = UIColor.lightGray.cgColor
		    imageView.layer.borderWidth = 0.8
	    	imageView.clipsToBounds = true
	    	imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	lazy var currencyUILabel: UILabel = {
		let label = UILabel()
	    	label.translatesAutoresizingMaskIntoConstraints = false
	    	label.font = regularFont
		    label.textColor = UIColor.lightGray
		    label.text = "GHS"
		return label
	}()
	
	lazy var currencyCountryNameUILabel: UILabel = {
		let label = UILabel()
	    	label.translatesAutoresizingMaskIntoConstraints = false
		    label.font = regularFont
	    	label.text = "Ghana"
		return label
	}()
	
	
}
