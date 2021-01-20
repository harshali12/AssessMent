//
//  Viewcontroller.swift
//  Assessment
//
//  Created by APPLE on 20/01/21.
//

import Foundation
import UIKit

extension UIViewController {
    func setGradientColor()  {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.orange.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        self.view.layer.insertSublayer(gradient, at: 0)
    }
}


