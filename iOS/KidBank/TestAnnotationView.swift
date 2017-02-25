//
//  TestAnnotationView.swift
//  HDAugmentedRealityDemo
//
//  Created by Danijel Huis on 30/04/15.
//  Copyright (c) 2015 Danijel Huis. All rights reserved.
//

import UIKit

open class TestAnnotationView: ARAnnotationView, UIGestureRecognizerDelegate
{
    open var img: UIImageView?
    
    override open func didMoveToSuperview()
    {
        super.didMoveToSuperview()
        if self.img == nil
        {
            self.loadUi()
        }
    }
    
    func loadUi()
    {
        self.img?.removeFromSuperview()
        let img = UIImageView()
        img.backgroundColor = UIColor.clear
        img.image = UIImage(named: "atm")!
        self.addSubview(img)
        self.img = img
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.layer.cornerRadius = 5
        
        if self.annotation != nil
        {
            self.bindUi()
        }
    }
    
    func layoutUi()
    {
        let buttonWidth: CGFloat = 90
        
        self.img?.frame = CGRect(x: 10, y: 0, width: self.frame.size.width - buttonWidth - 5, height: self.frame.size.height);

    }
    
    // This method is called whenever distance/azimuth is set
    override open func bindUi()
    {
    }
    
    open override func layoutSubviews()
    {
        super.layoutSubviews()
        self.layoutUi()
    }
    
    open func tapGesture()
    {
        
    }
    
    
}
