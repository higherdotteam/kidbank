//  Created by Danijel Huis on 23/04/15.
//  Copyright (c) 2015 Danijel Huis. All rights reserved.

import UIKit

open class ARAnnotationView: UIView
{
    open weak var annotation: ARAnnotation?
    fileprivate var initialized: Bool = false
    
    public init()
    {
        super.init(frame: CGRect.zero)
        self.initializeInternal()
    }

    public required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.initializeInternal()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.initializeInternal()
    }
    
    fileprivate func initializeInternal()
    {
        if self.initialized
        {
            return
        }
        self.initialized = true;
        self.initialize()
    }
    
    open override func awakeFromNib()
    {
        self.bindUi()
    }
    
    open func initialize()
    {
    
    }
    
    open func bindUi()
    {
        
    }
}
