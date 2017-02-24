//  Created by Danijel Huis on 23/04/15.
//  Copyright (c) 2015 Danijel Huis. All rights reserved.

import UIKit
import CoreLocation

open class ARAnnotation: NSObject
{
    open var title: String?
    open var location: CLLocation?
    internal(set) open var annotationView: ARAnnotationView?
    
    internal(set) open var distanceFromUser: Double = 0
    internal(set) open var azimuth: Double = 0
    internal(set) open var verticalLevel: Int = 0
    internal(set) open var active: Bool = false

}
