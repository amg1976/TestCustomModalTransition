//
//  OtherViewController.swift
//  TestCustomModalTransition
//
//  Created by Adriano Goncalves on 25/05/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {

    let customPresentAnimationController = CustomPresentAnimationController()
    
    @IBAction func touchedButton(sender: AnyObject) {
        customPresentAnimationController.presenting = false
        transitioningDelegate = self
        modalPresentationStyle = .Custom
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension OtherViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }

}