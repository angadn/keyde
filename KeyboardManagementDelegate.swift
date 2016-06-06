//
//  KeyboardManagementDelegate.swift
//  tincan-sdk
//
//  Created by Angad Nadkarni on 02/06/16.
//  Copyright © 2016 Hullo Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

public class KeyboardManagementDelegate {
    
    private let targetView: UIView
    private var rootViewFrameOriginY: CGFloat = 0
    private var alreadyAdjustedFrame: Bool = false
    
    init(targetView: UIView) {
        self.targetView = targetView
    }
    
    func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(KeyboardManagementDelegate.keyboardWillAppear(_:)),
            name: UIKeyboardWillShowNotification, object: nil
        )
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(KeyboardManagementDelegate.keyboardWillDisappear(_:)),
            name: UIKeyboardWillHideNotification, object: nil
        )
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(KeyboardManagementDelegate.orientationChanged(_:)),
            name: UIDeviceOrientationDidChangeNotification, object: nil
        )
    }
    
    func viewWillDisappear(animated: Bool) {
        keyboardWillDisappear(nil)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func ensureKeyboardShut() {
        targetView.endEditing(true)
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        let info = notification.userInfo!
        if (info[UIKeyboardFrameEndUserInfoKey] != nil) {
            let keyboardFrame: CGRect = (
                info[UIKeyboardFrameEndUserInfoKey] as! NSValue
            ).CGRectValue()
            
            if (!self.alreadyAdjustedFrame) {
                self.rootViewFrameOriginY = self.targetView.frame.origin.y
                self.targetView.frame.origin.y -= keyboardFrame.size.height - 50
                
                self.alreadyAdjustedFrame = true
            }
        } else {
            self.alreadyAdjustedFrame = true // To fix behavior in case of 'gravity' position
        }
    }
    
    @objc func keyboardWillDisappear(notification: NSNotification?) {
        self.targetView.frame.origin.y = self.rootViewFrameOriginY
        self.alreadyAdjustedFrame = false
    }
    
    @objc func orientationChanged(notification: NSNotification) {
        if (self.alreadyAdjustedFrame) {
            self.alreadyAdjustedFrame = false
            keyboardWillAppear(notification)
        }
    }

}
