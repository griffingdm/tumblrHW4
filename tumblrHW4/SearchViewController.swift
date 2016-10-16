//
//  SearchViewController.swift
//  tumblrHW4
//
//  Created by Mullins, Griffin on 10/16/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var searchFeedView: UIImageView!

    var loadingImages: [UIImage]!
    var animatedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFeed()
    }

    func loadFeed(){
        // Do any additional setup after loading the view.
        loadingImages = [#imageLiteral(resourceName: "loading-1"), #imageLiteral(resourceName: "loading-2"), #imageLiteral(resourceName: "loading-3")]
        animatedImage = UIImage.animatedImage(with: loadingImages, duration: 1.0)
        loadingImage.image = animatedImage
        
        loadingImage.alpha = 1
        searchFeedView.alpha = 0
        
        delay(2) {
            UIView.animate(withDuration: 0.25, animations: {
                self.loadingImage.alpha = 0
                self.searchFeedView.alpha = 1
                }, completion: { (Bool) in
            })
        }
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
