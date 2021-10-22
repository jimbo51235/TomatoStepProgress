//
//  TomatoCircleView.swift
//  TomatoTopProgress
//
//  Created by Tomato on 2021/10/21.
//

import UIKit

class TomatoCircleView: UIView {
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
		
		let bounds = self.bounds
		let centerPoint = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
		let start = CGFloat(3 * Double.pi / 2.0)
		let end = start + CGFloat(2 * Double.pi * 1.0)
		let path = UIBezierPath(arcCenter: centerPoint, radius: bounds.width / 2.0, startAngle: start, endAngle: end, clockwise: true)
		let shapeLayer = CAShapeLayer()
		shapeLayer.path = path.cgPath
		shapeLayer.fillColor = fillColor.cgColor
		shapeLayer.strokeColor = strokeColor.cgColor
		shapeLayer.lineWidth = lineWidth
		layer.addSublayer(shapeLayer)
	}
}
