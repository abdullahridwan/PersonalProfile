//
//  SlideInTransition.swift
//  Slide_Transition
//
//  Created by Abdullah Ridwan on 12/23/19.
//  Copyright © 2019 Abdullah Ridwan. All rights reserved.
//

import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    //add a flag to determine wheter we are presenting this view controller
    //when presenting -> true ; when dismissing -> false
    var isPresenting = false
    let dimmingView = UIView()
    
    //has 2 methods
    //duration of transition
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    
    //actual functions where we animate the transition
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //1. pull out view controller that we're transitioning to
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        
        //2. ask transitioning context for a container view
        let containerView = transitionContext.containerView
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting {
            //Add dimming view
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            //first add menuviewcontroller which is the vc we're transitioning to, to our container view
            containerView.addSubview(toViewController.view)
            
            //now set an initial frame off the screen
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //Animate onto screen
        let transform = {
            self.dimmingView.alpha = 0.4
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        //Animate back off screen
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
       
        
        
        UIView.animate(withDuration: duration ,
                       animations: {self.isPresenting ? transform() : identity()
        }) {(true) in
            transitionContext.completeTransition(!isCancelled)
        }
        
    }

}
