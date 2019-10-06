//
//  GenericTableView.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//


import UIKit
class GenericTableView<T, Cell: UITableViewCell>: UITableView ,UITableViewDelegate,UITableViewDataSource {
	
	var viewController : UIViewController!
	var items: [T]
	var configure: (Cell, T) -> Void
	var selectHandler: (_ model:T,Cell) -> Void
	var tableView : UITableView!
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(items: [T], configure: @escaping (Cell, T) -> Void, selectHandler: @escaping (T, Cell) -> Void) {
		
		self.items = items
		self.configure = configure
		self.selectHandler = selectHandler
		super.init(frame: .zero, style: .plain)
		self.register(Cell.self, forCellReuseIdentifier: "Cell")
		self.separatorStyle = .none
		self.showsVerticalScrollIndicator = false
		self.showsHorizontalScrollIndicator = false
		self.delegate = self
		self.dataSource = self
		self.tableView = self
		self.translatesAutoresizingMaskIntoConstraints = false
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
		let item = items[indexPath.row]
		configure(cell, item)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let cell = tableView.cellForRow(at: indexPath)  as! Cell
		let item = items[indexPath.row]
		selectHandler(item,cell)
	}
	
	
	
	
}
