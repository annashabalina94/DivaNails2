//
//  LargeImageViewController.swift
//  DivaNails2
//
//  Created by Anna Shabalina on 11/1/17.
//  Copyright © 2017 Anna Shabalina. All rights reserved.
//

import UIKit

class LargeImageViewController: UIViewController, UIScrollViewDelegate
{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var linkLabel: UILabel!
    @IBOutlet var largeImage: UIImageView!
    
    var linkText = String()
    var limage = UIImage()
   
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        linkLabel.text = linkText
        largeImage.image = limage
        
        
    }
    
    @IBAction func back(_ sender: UIButton)
    {
       _ = self.dismiss(animated: true, completion: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.largeImage
    }
    
    
}
