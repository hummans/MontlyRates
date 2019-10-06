//
//  CurrencyDetailViewController.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class RatesDetailViewController: UIViewController {
	
	var ratesDetailView : RatesDetailUIView!
	var keyCurrency : String!
	var convertedRates : [RatesConvertedModel]  = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ratesDetailView = RatesDetailUIView(frame: .zero,
																						parentView: self,
																						model: convertedRates)
			
			guard let titleText = keyCurrency else { return  }
			self.title = titleText

    }
	
    
  ///TODO Move to a Base class show other viewcontroller's can extend and implement same methods
	func setUpSubViewsAndConstrainViews(){
		   self.view.addSubview(ratesDetailView)
		   ratesDetailView.constrainToSuperView(on: self.view)
	}
	
	override func viewDidLayoutSubviews() {
		    setUpSubViewsAndConstrainViews()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		

	}
}
