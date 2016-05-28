//
//  ViewController.swift
//  TestCustomModalTransition
//
//  Created by Adriano Goncalves on 25/05/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let customPresentAnimationController = CustomPresentAnimationController()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destination = segue.destinationViewController as? OtherViewController {
            destination.transitioningDelegate = self
            destination.modalPresentationStyle = .Custom
        }
        
    }


}

extension ViewController: UIViewControllerTransitioningDelegate {

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    
}

class CustomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    var presenting = true
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        let bounds = UIScreen.mainScreen().bounds
        toViewController.view.frame = bounds
        
        if presenting {
            containerView!.addSubview(toViewController.view)
        }
        
        toViewController.view.alpha = 0
        toViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
        
        UIView.animateWithDuration(0.15, animations: {
            
            fromViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
            
            
        }) { (finished) in
        }
        
        UIView.animateWithDuration(0.15, delay: 0.1, options: UIViewAnimationOptions(), animations: {
            
            fromViewController.view.alpha = 0
            
            
        }) { (finished) in

            if !self.presenting {
                fromViewController.view.hidden = true
            }

        }
        
        UIView.animateWithDuration(0.15, delay: 0.1, options: UIViewAnimationOptions(), animations: {
            
            toViewController.view.transform = CGAffineTransformIdentity
            toViewController.view.alpha = 1
            
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
                fromViewController.view.alpha = 1
                fromViewController.view.transform = CGAffineTransformIdentity
        })


    }
    
}