//
//  RadiusView.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import UIKit

@IBDesignable class RadiusView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        frame = CGRect(x: 20, y: 20, width: frame.size.width, height: frame.size.height)
        
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true
    }
}
