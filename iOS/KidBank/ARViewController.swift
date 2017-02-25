//  Created by Danijel Huis on 23/04/15.
//  Copyright (c) 2015 Danijel Huis. All rights reserved.

import UIKit
import AVFoundation
import CoreLocation

open class ARViewController: UIViewController, ARTrackingManagerDelegate
{
    open weak var dataSource: ARDataSource?
    fileprivate(set) open var trackingManager: ARTrackingManager = ARTrackingManager()
    
    fileprivate var initialized: Bool = false
    fileprivate var cameraSession: AVCaptureSession = AVCaptureSession()
    fileprivate var overlayView: OverlayView = OverlayView()
    fileprivate var displayTimer: CADisplayLink?
    fileprivate var cameraLayer: AVCaptureVideoPreviewLayer?    // Will be set in init
    fileprivate var annotationViews: [ARAnnotationView] = []
    fileprivate var didLayoutSubviews: Bool = false
    
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
        self.overlayView.removeFromSuperview()
        self.overlayView = OverlayView()
        self.view.addSubview(self.overlayView)
    }
    
    fileprivate func overlayFrame() -> CGRect
    {
        let x: CGFloat = self.view.bounds.size.width / 2 - (CGFloat(270) * H_PIXELS_PER_DEGREE)
        let y: CGFloat = (CGFloat(self.trackingManager.pitch) * VERTICAL_SENS) + 60.0
        
        let newFrame = CGRect(x: x, y: y, width: OVERLAY_VIEW_WIDTH, height: self.view.bounds.size.height)
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
        
        annotation.annotationView = nil
        
        annotation.annotationView = self.dataSource?.ar(self, viewForAnnotation: annotation)
        annotation.annotationView!.bindUi()
        
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
    
    internal func displayTimerTick()
    {
        let newHeading = self.trackingManager.heading
        
        NSLog("55555555 \(newHeading)")
        
        self.overlayView.frame = self.overlayFrame()
        //self.updateAnnotationsForCurrentHeading()
        
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



