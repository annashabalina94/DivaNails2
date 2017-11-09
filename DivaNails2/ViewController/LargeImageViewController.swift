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
    
    @IBOutlet var largeImage: UIImageView!
    
    var linkText = String()
    var limage = UIImage()
   
    @IBAction func userDoubleTappedScrollview(_ sender: UITapGestureRecognizer)
        {
        // Want to zoom in and zoom out animation
        //print("Tapped")
        }
    
    
    @IBOutlet weak var Buttontext: UIButton!
    
    
    override func viewDidLoad()
        {
            super.viewDidLoad()
            //linkLabel.text = linkText
            Buttontext.setTitle(linkText, for: .normal)
            largeImage.image = limage
        }
    
    
    @IBAction func linkButton(_ sender: Any)
        {
            let url =  URL(string: linkText)!
            UIApplication.shared.open(url)
        }
    
    
    @IBAction func back(_ sender: UIButton)
        {
            _ = self.dismiss(animated: true, completion: nil)
        }

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
        {
            return self.largeImage
        }
    
}
