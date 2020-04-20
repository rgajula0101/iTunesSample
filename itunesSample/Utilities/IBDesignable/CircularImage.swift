//
//  CircularImage.swift
//  itunesSample
//
//  Created by Rakesh Kumar on 04/16/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class CircularImage: UIImageView {
    
    
    @IBInspectable var cornerRadius: CGFloat = 20 {
        didSet {
            refreshCorners(value: cornerRadius)
            self.clipsToBounds = true
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
        self.clipsToBounds = true
        
    }
}
