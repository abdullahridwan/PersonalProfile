//
//  ViewController.swift
//  Slide_Transition
//
//  Created by Abdullah Ridwan on 12/23/19.
//  Copyright © 2019 Abdullah Ridwan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let transition = SlideInTransition()
    var topView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier:"MenuViewController") as? MenuViewController else {return}
        menuViewController.didTapMenuType = {menuType in
            //function that transitions hvc to diff content
            self.transitionToNew(_menuType: menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func transitionToNew(_menuType: MenuType) {
        //pass in menutype
        let title = String(describing: _menuType).capitalized
        self.title = title
        
        topView.removeFromSuperview()
        switch _menuType {
        case .profile:
            let view = UIView()
            view.backgroundColor = .yellow
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        case .camera:
            let view = UIView()
            view.backgroundColor = .blue
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        default:
            break
        }
    }
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

