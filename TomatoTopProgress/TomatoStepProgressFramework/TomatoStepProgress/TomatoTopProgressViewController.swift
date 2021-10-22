//
//  TomatoTopProgressViewController.swift
//  TomatoTopProgress
//
//  Created by Tomato on 2021/10/21.
//

import UIKit

open class TomatoStepProgressViewController: UIViewController {
	public var blinkingSpeed: TimeInterval = 0.75
	public var blinkCurrent: Bool = true
	/* edges */
	public var topEdge: CGFloat = 0.0
	public var sideEdge: CGFloat = 20.0 // left and right
	/* circle */
	public var circleDiameter: CGFloat = 24.0
	public var onFillColor: UIColor = .green
	public var offFillColor: UIColor = .white
	public var incompleteFillColor: UIColor = .white
	public var strokeColor: UIColor = .black
	public var strokeWidth: CGFloat = 2.0
	/* label */
	public var textPosition: CGFloat = 10.0
	public var textColor: UIColor = .black
	public var textSize: CGFloat = 14.0
	public var labelHeight: CGFloat = 14.0
	public var labelBackColor: UIColor = .clear
	/* path */
	public var pathHeight: CGFloat = 10.0
	public var pathWidth: CGFloat = 1.0
	public var pathStrokeColor: UIColor = .black
	public var completePathColor: UIColor = .blue
	public var incompletePathColor: UIColor = .lightGray
	public var startPathColor: UIColor = .blue
	public var goalPathColor: UIColor = .blue
	/* container */
	public var containerBackColor: UIColor = .clear
	
	var containerView = UIView()
	var onCircleView = UIView()
	public var tomatoProgressModels = [TomatoProgressModel]()
	public func tomatoProgressSetup(index: Int) {
		/* validation */
		if !isHorizontalMenuModelsValid() {
			print("Your progress model array does not contain unique index numbers.")
			return
		}
		
		/* checking the top position */
		var topHeight: CGFloat = 0.0
		if let navigationController = navigationController, let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, let statusManager = window.windowScene?.statusBarManager {
			let statusFrame = statusManager.statusBarFrame
			let navigationFrame = navigationController.navigationBar.frame
			topHeight = statusFrame.height + navigationFrame.height
		}
		
		let deviceSize = UIScreen.main.bounds.size
		let lineWidth = deviceSize.width - (circleDiameter + strokeWidth)
		let lineStep = (lineWidth - sideEdge * 2.0) / CGFloat(tomatoProgressModels.count - 1)
		let containerRect = CGRect(x: 0.0, y: topHeight + topEdge, width: deviceSize.width, height: circleDiameter + strokeWidth + textPosition + labelHeight)
		containerView = UIView(frame: containerRect)
		containerView.backgroundColor = containerBackColor
		
		/* initial line */
		let lineRect0 = CGRect(x: 0.0, y: strokeWidth / 2.0 + circleDiameter / 2.0 - pathHeight / 2.0, width: sideEdge + strokeWidth + strokeWidth / 2.0, height: pathHeight)
		let lineView0 = TomatoLineView(frame: lineRect0, fillColor: startPathColor, strokeColor: pathStrokeColor, lineWidth: pathWidth)
		containerView.addSubview(lineView0)
		
		for i in 0..<tomatoProgressModels.count {
			let model = tomatoProgressModels[i]
			/* line */
			if i < tomatoProgressModels.count - 1 {
				let x0 = sideEdge - strokeWidth / 2.0 + CGFloat(i) * lineStep + circleDiameter
				let y0 = strokeWidth / 2.0 + circleDiameter / 2.0 - pathHeight / 2.0
				let lineColor = (i < index) ? completePathColor : incompletePathColor
				let x1 = sideEdge - strokeWidth  + CGFloat(i + 1) * lineStep + circleDiameter
				let w0 = x1 - x0
				let lineRect = CGRect(x: x0, y: y0, width: w0, height: pathHeight)
				let lineView = TomatoLineView(frame: lineRect, fillColor: lineColor, strokeColor: pathStrokeColor, lineWidth: pathWidth)
				containerView.addSubview(lineView)
			}
			else {
				let x = sideEdge - strokeWidth + CGFloat(tomatoProgressModels.count - 1) * lineStep + circleDiameter
				let y = strokeWidth / 2.0 + circleDiameter / 2.0 - pathHeight / 2.0
				let lineRect = CGRect(x: x, y: y, width: sideEdge + strokeWidth * 2.0, height: pathHeight)
				let lineView = TomatoLineView(frame: lineRect, fillColor: goalPathColor, strokeColor: pathStrokeColor, lineWidth: pathWidth)
				containerView.addSubview(lineView)
			}
			
			/* circle */
			let fillColor = (i == index) ? onFillColor : incompleteFillColor
			let circleRect = CGRect(x: sideEdge + strokeWidth / 2.0 + CGFloat(i) * lineStep, y: strokeWidth / 2.0, width: circleDiameter, height: circleDiameter)
			let circleView = TomatoCircleView(frame: circleRect, fillColor: fillColor, strokeColor: strokeColor, lineWidth: strokeWidth)
			let offView = TomatoCircleView(frame: circleRect, fillColor: offFillColor, strokeColor: strokeColor, lineWidth: strokeWidth)
			if i == index {
				containerView.addSubview(offView)
			}
			containerView.addSubview(circleView)
			if i == index {
				onCircleView = circleView
			}
			/* label */
			let name = model.name
			let attr = NSMutableAttributedString(string: name)
			let font = UIFont.systemFont(ofSize: textSize)
			attr.addAttributes([NSAttributedString.Key.font : font], range: NSMakeRange(0, name.count))
			let labelOriginX = circleRect.origin.x + (circleRect.width - attr.size().width) / 2.0
			let labelRect = CGRect(x: labelOriginX, y: circleDiameter + strokeWidth + textPosition, width: attr.size().width, height: labelHeight)
			let label = makeLabel(labelRect: labelRect, text: name)
			label.backgroundColor = labelBackColor
			containerView.addSubview(label)
		}
		view.addSubview(containerView)
		
		if blinkCurrent {
			Timer.scheduledTimer(timeInterval: blinkingSpeed, target: self, selector: #selector(currentOnOff), userInfo: nil, repeats: true)
		}
	}
	
	func makeLabel(labelRect: CGRect, text: String) -> UILabel {
		//let labelRect = CGRect(x: point.x, y: point.y, width: attributedStr.size().width, height: labelHeight)
		let label = UILabel(frame: labelRect)
		label.text = text
		label.font = UIFont.systemFont(ofSize: textSize)
		label.textAlignment = .center
		label.textColor = textColor
		return label
	}
	
	var isShowing = true
	@objc func currentOnOff() {
		if self.isShowing {
			self.onCircleView.isHidden = true
			self.isShowing = false
		} else {
			self.onCircleView.isHidden = false
			self.isShowing = true
		}
	}
	
	
	// MARK: - Validating models
	func isHorizontalMenuModelsValid() -> Bool {
		var array = [Int]()
		for i in 0..<tomatoProgressModels.count {
			let model = tomatoProgressModels[i]
			let index = model.index
			if index >= 0 && index < tomatoProgressModels.count {
				if !array.contains(index) {
					array.append(index)
				}
			}
		}
		if array.count == tomatoProgressModels.count {
			return true
		} else {
			return false
		}
	}
}

public struct TomatoProgressModel {
	public let name: String
	public let index: Int
	
	public init(name: String, index: Int) {
		self.name = name
		self.index = index
	}
}

