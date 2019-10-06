
//
//  Extensions.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//



import UIKit


//- Ofcourse, these extensions should be in seperate files


extension UIViewController {
	func showBanner(title:String,message:String,type:NotificiationType){
		guard let parentView = self.navigationController else { return  }
		      NotificationBanner(parentView: parentView,
														 title: title,
														 message: message,
														 bannerType: type).show()
		
	}
}

extension UIView {
	
	var regularFont : UIFont {
		return UIFont.init(name: ".SFUIDisplay", size: 17) ?? UIFont.systemFont(ofSize: 17)
	}
	var mediumFont : UIFont {
		return UIFont.init(name: ".SFUIDisplay-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
	}
	func constrainToSuperView(on view : UIView){
		let guide = view.safeAreaLayoutGuide
		self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
		self.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
		
	}
	func constrainTopOfSuperView(on view : UIView,
															 leadingConstant:CGFloat = 0,
															 trailingConstant : CGFloat = 0){
		let guide = view.safeAreaLayoutGuide
		self.leadingAnchor.constraint(equalTo: guide.leadingAnchor,constant: leadingConstant).isActive = true
		self.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant: trailingConstant).isActive = true
		self.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
		
	}
	func constrainBelowSuperViewsTopView(superview : UIView,
																			 below topview : UIView,
																			 spacing: CGFloat = 0){
		
		let guide = superview.safeAreaLayoutGuide
		self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
		self.topAnchor.constraint(equalTo: topview.bottomAnchor,constant: spacing).isActive = true
		
	}
	func addBottomBorder(color: UIColor, width: CGFloat) {
		let border = UIView()
		border.backgroundColor = color
		border.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(border)
		border.addConstraint(NSLayoutConstraint(item: border,
																						attribute: NSLayoutConstraint.Attribute.height,
																						relatedBy: NSLayoutConstraint.Relation.equal,
																						toItem: nil,
																						attribute: NSLayoutConstraint.Attribute.height,
																						multiplier: 1, constant: 1))
		self.addConstraint(NSLayoutConstraint(item: border,
																					attribute: NSLayoutConstraint.Attribute.bottom,
																					relatedBy: NSLayoutConstraint.Relation.equal,
																					toItem: self,
																					attribute: NSLayoutConstraint.Attribute.bottom,
																					multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: border,
																					attribute: NSLayoutConstraint.Attribute.leading,
																					relatedBy: NSLayoutConstraint.Relation.equal,
																					toItem: self,
																					attribute: NSLayoutConstraint.Attribute.leading,
																					multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: border,
																					attribute: NSLayoutConstraint.Attribute.trailing,
																					relatedBy: NSLayoutConstraint.Relation.equal,
																					toItem: self,
																					attribute: NSLayoutConstraint.Attribute.trailing,
																					multiplier: 1, constant: 0))
	}
}

extension UITableView {
	func fancyReload(){
		self.performBatchUpdates(
			{
				self.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableView.RowAnimation.fade)
		}, completion: { (finished:Bool) -> Void in
		})
	}
 }

extension Data {
	var toString : String {
		guard let dataString = String(data:  self, encoding: .utf8) else { return "nil" }
		return dataString
	}
 }


extension String {
	var flagImage : UIImage? {
		if let anImage = UIImage(named: self) {
			return anImage
		}
		return nil
	}
	var humanReadableMonth : String {
		let isoDate = self.toDate()
		let formatter = DateFormatter()
		formatter.dateFormat = "MMMM yyyy"
		let date = formatter.string(from: isoDate)
		return date
	}
	func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		guard let date = dateFormatter.date(from: self) else {
			preconditionFailure("Take a look to your format")
		}
		return date
  	}
  }

 extension Dictionary {
	mutating func update(other:Dictionary) {
		for (key,value) in other {
			self.updateValue(value, forKey:key)
		}
	}
}

extension Double {
	var percentageStyleFormat : String {
		return 	String(format:"%+6.3f%%", self/100)
	}
}

func background(work: @escaping () -> ()) {
	DispatchQueue.global(qos: .background).async {
		work()
	}
}
func main(work: @escaping () -> ()) {
	DispatchQueue.main.async {
		work()
	}
}
func delay(time: Double,work: @escaping () -> ()){
	DispatchQueue.main.asyncAfter(deadline: .now() + time) {
		work()
	}
}
