//
//  TomatoLineView.swift
//  TomatoTopProgress
//
//  Created by Tomato on 2021/10/21.
//

import UIKit

class TomatoLineView: UIView {
	let fillColor: UIColor
	let strokeColor: UIColor
	let lineWidth: CGFloat
	
	init(frame: CGRect, fillColor: UIColor, strokeColor: UIColor, lineWidth: CGFloat) {
		self.fillColor = fillColor
		self.strokeColor = strokeColor
		self.lineWidth = lineWidth
		super.init(frame: frame)
		self.backgroundColor = UIColor.clear
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		let shapeLayer = CAShapeLayer()
		let path = UIBezierPath()
		path.move(to: CGPoint.zero)
		path.addLine(to: CGPoint(x: bounds.width, y: 0.0))
		path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
		path.addLine(to: CGPoint(x: 0.0, y: bounds.height))
		path.close()
		shapeLayer.path = path.cgPath
		shapeLayer.fillColor = fillColor.cgColor
		shapeLayer.strokeColor = strokeColor.cgColor
		shapeLayer.lineWidth = lineWidth
		layer.addSublayer(shapeLayer)
	}
}

