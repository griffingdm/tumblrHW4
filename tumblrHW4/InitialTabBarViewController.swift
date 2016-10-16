//
//  InitialTabBarViewController.swift
//  tumblrHW4
//
//  Created by Mullins, Griffin on 10/16/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class InitialTabBarViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var tabButtons: [UIButton]!
    @IBOutlet weak var popoverImage: UIImageView!
    
    var homeViewController: UIViewController!
    var searchViewController: UIViewController!
    var accountViewController: UIViewController!
    var trendingViewController: UIViewController!
    var viewControllers: [UIViewController]!
    
    var popoverDistance: CGFloat = 5
    let popoverAnimateTime: Double = 0.7
    
    var selectedIndex: Int = 0

    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
        searchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController")
        accountViewController = storyBoard.instantiateViewController(withIdentifier: "AccountViewController")
        trendingViewController = storyBoard.instantiateViewController(withIdentifier: "TrendingViewController")
        viewControllers = [homeViewController, searchViewController, accountViewController, trendingViewController]
        
        tapTabButton(tabButtons[selectedIndex])
        
        animatePopover()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapTabButton(_ sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        tabButtons[previousIndex].isSelected = false
        
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        sender.isSelected = true
        
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
        if vc != searchViewController {
            popoverImage.isHidden = false
        } else {
            popoverImage.isHidden = true
        }
    }
    
    func animatePopover(){
        UIView.animate(withDuration:popoverAnimateTime, animations: {
            self.popoverImage.frame.origin.y += self.popoverDistance
            }) { (Bool) in
                self.popoverDistance = self.popoverDistance * -1
                self.animatePopover()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue!")
        
        // Get the new view controller using segue.destinationViewController.
        let destinationViewController = segue.destination
        
        // Set the modal presentation style of your destinationViewController to be custom.
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        
        // Create a new instance of your fadeTransition.
        fadeTransition = FadeTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        destinationViewController.transitioningDelegate = fadeTransition
        
        // Adjust the transition duration. (seconds)
        fadeTransition.duration = 1.0
    }
 

}
