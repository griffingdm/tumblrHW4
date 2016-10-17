//
//  ComposeViewController.swift
//  tumblrHW4
//
//  Created by Mullins, Griffin on 10/16/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet var composeButtons: [UIButton]!
    
    var ogButtonPoints: [CGPoint]! = []
    let animationDuration: Double = 0.5
    let springDamp: CGFloat = 0.95
    let lowestSpringVel: UInt32 = 10
    let velRange: UInt32 = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for button in composeButtons {
            ogButtonPoints.append(button.frame.origin)
            button.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButtons(hide: false)
    }
    
    func animateButtons(hide: Bool){
        for (index, button) in composeButtons.enumerated() {
            let velocity = CGFloat(arc4random_uniform(velRange) + lowestSpringVel)
            var newPoint: CGPoint = ogButtonPoints[index]
            button.isHidden = false
            
            switch hide {
            case false:
                button.frame.origin.y += view.frame.height
            default:
                newPoint = CGPoint(x: newPoint.x, y: button.frame.origin.y - view.frame.height)
            }
            
            UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: springDamp, initialSpringVelocity: velocity, options: [],animations: {
                //animation code
                button.frame.origin = newPoint
                }, completion: { (Bool) in
                    //what to do after the animation
                    if hide {
                        self.dismiss(animated: true, completion: {})
                        button.isHidden = true
                    }
            })
        }
    }
    
    @IBAction func tapNevermind(_ sender: AnyObject) {
        animateButtons(hide: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
