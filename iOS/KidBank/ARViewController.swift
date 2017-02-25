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
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        self.initializeInternal()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    
    fileprivate func onViewWillAppear()
    {
        if self.cameraLayer?.superlayer == nil { self.loadCamera() }
        //if self.overlayView.superview == nil { self.loadOverlay() }
        self.startCamera(notifyLocationFailure: true)
    }
    
    internal func displayTimerTick()
    {
        let newHeading = self.trackingManager.heading
        
        NSLog("55555555 \(newHeading)")
        
        //self.overlayView.frame = self.overlayFrame()
        //self.updateAnnotationsForCurrentHeading()
        
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



