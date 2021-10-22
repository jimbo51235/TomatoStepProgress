//
//  BaseViewController.swift
//  TomatoTopProgress
//
//  Created by Tomato on 2021/10/21.
//

import UIKit
import TomatoStepProgress

class BaseViewController: TomatoStepProgressViewController {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
		super.init(nibName: nil, bundle: nil)
	}
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}
	
	func setup(index: Int) {
		blinkingSpeed = 1.25
		blinkCurrent = true
		/* edges */
		topEdge = 0.0
		sideEdge = 10.0
		/* circle */
		circleDiameter = 20.0
		onFillColor = .green
		offFillColor = .red
		incompleteFillColor = .gray
		strokeColor = .black
		strokeWidth = 1.0
		/* label */
		textPosition = 8.0
		textColor = .black
		textSize = 12.0
		labelHeight = 12.0
		labelBackColor = .clear
		/* path */
		pathHeight = 10.0
		pathWidth = 1.0
		pathStrokeColor = .black
		completePathColor = .green
		incompletePathColor = .white
		startPathColor = .darkGray
		goalPathColor = .darkGray
		
		let model0 = TomatoProgressModel(name: "Step 1", index: 0)
		let model1 = TomatoProgressModel(name: "Step 2", index: 1)
		let model2 = TomatoProgressModel(name: "Step 3", index: 2)
		let model3 = TomatoProgressModel(name: "Step 4", index: 3)
		let model4 = TomatoProgressModel(name: "Step 5", index: 4)
		tomatoProgressModels = [model0, model1, model2, model3, model4]
		tomatoProgressSetup(index: index)
	}
}

