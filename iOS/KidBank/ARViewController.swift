//  Created by Danijel Huis on 23/04/15.
//  Copyright (c) 2015 Danijel Huis. All rights reserved.

import UIKit
import AVFoundation
import CoreLocation

open class ARViewController: UIViewController, ARTrackingManagerDelegate
{
    open weak var dataSource: ARDataSource?
    open var headingSmoothingFactor: Double = 1
    fileprivate(set) open var trackingManager: ARTrackingManager = ARTrackingManager()
    
    fileprivate var initialized: Bool = false
    fileprivate var cameraSession: AVCaptureSession = AVCaptureSession()
    fileprivate var overlayView: OverlayView = OverlayView()
    fileprivate var displayTimer: CADisplayLink?
    fileprivate var cameraLayer: AVCaptureVideoPreviewLayer?    // Will be set in init
    fileprivate var annotationViews: [ARAnnotationView] = []
    fileprivate var didLayoutSubviews: Bool = false
    fileprivate var currentHeading: Double = 0
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        self.initializeInternal()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeInternal()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializeInternal()
    }
    
    internal func initializeInternal()
    {
        if self.initialized
        {
            return
        }
        self.initialized = true;
        self.trackingManager.delegate = self
        NSLog("trackingManager.startTracking");
        self.trackingManager.startTracking(notifyLocationFailure: true)
    }
    
    open class func createCaptureSession() -> (session: AVCaptureSession?, error: NSError?)
    {
        var error: NSError?
        var captureSession: AVCaptureSession?
        var backVideoDevice: AVCaptureDevice?
        let videoDevices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        
        if let videoDevices = videoDevices
        {
            for captureDevice in videoDevices
            {
                if (captureDevice as AnyObject).position == AVCaptureDevicePosition.back
                {
                    backVideoDevice = captureDevice as? AVCaptureDevice
                    break
                }
            }
        }
        
        if backVideoDevice != nil
        {
            var videoInput: AVCaptureDeviceInput!
            do {
                videoInput = try AVCaptureDeviceInput(device: backVideoDevice)
            } catch let error1 as NSError {
                error = error1
                videoInput = nil
            }
            if error == nil
            {
                captureSession = AVCaptureSession()
                
                if captureSession!.canAddInput(videoInput)
                {

                    captureSession!.addInput(videoInput)
                }
                else
                {
                    error = NSError(domain: "HDAugmentedReality", code: 10002, userInfo: ["description": "Error adding video input."])
                }
            }
            else
            {
                error = NSError(domain: "HDAugmentedReality", code: 10001, userInfo: ["description": "Error creating capture device input."])
            }
        }
        else
        {
            error = NSError(domain: "HDAugmentedReality", code: 10000, userInfo: ["description": "Back video device not found."])
        }
        
        return (session: captureSession, error: error)
    }

    
    fileprivate func loadCamera()
    {
        NSLog("loadCamera");
        self.cameraLayer?.removeFromSuperlayer()
        self.cameraLayer = nil
        
        let captureSessionResult = ARViewController.createCaptureSession()
        guard captureSessionResult.error == nil, let session = captureSessionResult.session else
        {
            print("HDAugmentedReality: Cannot create capture session, use createCaptureSession method to check if device is capable for augmented reality.")
            return
        }
        
        self.cameraSession = session
        
        if let cameraLayer = AVCaptureVideoPreviewLayer(session: self.cameraSession)
        {
            cameraLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.view.layer.insertSublayer(cameraLayer, at: 0)
            self.cameraLayer = cameraLayer
        }
    }
    
    fileprivate func layoutUi()
    {
        self.cameraLayer?.frame = self.view.bounds
        self.overlayView.frame = self.overlayFrame()
    }
    
    fileprivate func loadOverlay()
    {
        NSLog("loadOverlay")
        self.overlayView.removeFromSuperview()
        self.overlayView = OverlayView()
        self.view.addSubview(self.overlayView)
    }
    
    fileprivate func overlayFrame() -> CGRect
    {
        NSLog("loadOverlay[\(currentHeading)]")
        var x: CGFloat = self.view.bounds.size.width / 2 - (CGFloat(currentHeading) * H_PIXELS_PER_DEGREE)
        var y: CGFloat = (CGFloat(self.trackingManager.pitch) * VERTICAL_SENS) + 60.0
        
        x = 100
        y = 100
        
        let newFrame = CGRect(x: x, y: y, width: OVERLAY_VIEW_WIDTH, height: self.view.bounds.size.height)
        NSLog("frame [\(newFrame)]")
        return newFrame
    }
    
    open override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        onViewWillAppear()  // Doing like this to prevent subclassing problems
    }
    
    open override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        onViewDidAppear()   // Doing like this to prevent subclassing problems
    }
    
    open override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        onViewDidDisappear()    // Doing like this to prevent subclassing problems
    }
    
    fileprivate func onViewDidAppear()
    {
        
    }
    
    fileprivate func onViewDidDisappear()
    {
        //stopCamera()
    }
    
    open override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        onViewDidLayoutSubviews()
    }
    
    fileprivate func setOrientation(_ orientation: UIInterfaceOrientation)
    {
        NSLog("setOrientation[\(orientation.rawValue)]");
        if self.cameraLayer?.connection?.isVideoOrientationSupported != nil
        {
            if let videoOrientation = AVCaptureVideoOrientation(rawValue: Int(orientation.rawValue))
            {
                self.cameraLayer?.connection?.videoOrientation = videoOrientation
            }
        }
        
        if let deviceOrientation = CLDeviceOrientation(rawValue: Int32(orientation.rawValue))
        {
            self.trackingManager.orientation = deviceOrientation
        }
    }
    
    fileprivate func onViewWillAppear()
    {
        if self.cameraLayer?.superlayer == nil { self.loadCamera() }
        if self.overlayView.superview == nil { self.loadOverlay() }
        self.setOrientation(UIApplication.shared.statusBarOrientation)
        self.layoutUi();
        self.startCamera(notifyLocationFailure: true)
        
        let annotation = ARAnnotation()
        annotation.location = CLLocation(latitude: 34, longitude: -118.3)
        annotation.title = "ATM"
        
        var av: ARAnnotationView? = nil
        av = self.dataSource?.ar(self, viewForAnnotation: annotation)
        
        annotation.annotationView = av
        av!.annotation = annotation
        
        av!.bindUi()
        
        NSLog("addSubview \(annotation.annotationView!)");
        self.overlayView.addSubview(annotation.annotationView!)
    }
    
    fileprivate func onViewDidLayoutSubviews()
    {
        if !self.didLayoutSubviews
        {
            self.didLayoutSubviews = true
            self.layoutUi()
            self.view.layoutIfNeeded()
        }
        
        //self.degreesPerScreen = (self.view.bounds.size.width / OVERLAY_VIEW_WIDTH) * 360.0
        
    }
    
    fileprivate func updateAnnotationsForCurrentHeading()
    {
        let annotation = ARAnnotation()
        annotation.location = CLLocation(latitude: 34, longitude: -118.3)
        annotation.title = "ATM"
        
        var av: ARAnnotationView? = nil
        av = self.dataSource?.ar(self, viewForAnnotation: annotation)
        
        annotation.annotationView = av
        av!.annotation = annotation
        
        av!.bindUi()
        
        self.overlayView.addSubview(annotation.annotationView!)
    }
    
    internal func displayTimerTick()
    {
        let filterFactor: Double = headingSmoothingFactor
        let newHeading = self.trackingManager.heading
        
        // Picking up the pace if device is being rotated fast or heading of device is at the border(North). It is needed
        // to do this on North border because overlayView changes its position and we don't want it to animate full circle.
        if(self.headingSmoothingFactor == 1 || fabs(currentHeading - self.trackingManager.heading) > 50)
        {
            currentHeading = self.trackingManager.heading
        }
        else
        {
            // Smoothing out heading
            currentHeading = (newHeading * filterFactor) + (currentHeading  * (1.0 - filterFactor))
        }
        
        self.overlayView.frame = self.overlayFrame()
        self.updateAnnotationsForCurrentHeading()
        
        //logText("Heading: \(self.trackingManager.heading)")
    }
    
    internal func arTrackingManager(_ trackingManager: ARTrackingManager, didUpdateUserLocation: CLLocation?)
    {
    }
    
    internal func arTrackingManager(_ trackingManager: ARTrackingManager, didUpdateReloadLocation: CLLocation?)
    {
    }
    
    internal func arTrackingManager(_ trackingManager: ARTrackingManager, didFailToFindLocationAfter elapsedSeconds: TimeInterval)
    {
     
    }
    
    fileprivate func startCamera(notifyLocationFailure: Bool)
    {
        self.cameraSession.startRunning()
        self.trackingManager.startTracking(notifyLocationFailure: notifyLocationFailure)
        self.displayTimer = CADisplayLink(target: self, selector: #selector(ARViewController.displayTimerTick))
        self.displayTimer?.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    
    fileprivate class OverlayView: UIView
    {
       
    }
    
}



