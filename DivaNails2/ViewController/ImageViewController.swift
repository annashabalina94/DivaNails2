//
//  ImageViewController.swift
//  DivaNails2
//
//  Created by Anna Shabalina on 10/31/17.
//  Copyright © 2017 Anna Shabalina. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate
{
    
    let url = URL(string: "http://13.82.186.151:4040/photos/1")
    private var image = [Images]()

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadJson()
    }
    
    
    func downloadJson()
    {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL)
        { data, URLResponse, error in
            guard let data = data, error == nil, URLResponse != nil else
            {
                print("Something is wrong")
                return
            }
            print("downloaded")
            do
            {
                let decoder = JSONDecoder()
                let downloadedImage = try decoder.decode([Images].self, from: data)//fail
                self.image = downloadedImage
                DispatchQueue.main.async
                    {
                    self.collectionView.reloadData()
                    }
            }
                catch
            {
                print("Something wrong after downloading")
            }
        }.resume()
        
    }
    
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return image.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        
        if let imageURL = URL(string: self.image[indexPath.row].small)
        {
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                        {
                          let image = UIImage (data: data)
                        DispatchQueue.main.async
                            {
                                  cell.ImageCellView.image = image
                            }
                        }
                }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LargeImageViewController") as! LargeImageViewController
        
        let url = URL(string: self.image[indexPath.row].large)
        let data = try? Data(contentsOf: url!)
        vc.limage = UIImage(data: data!)!
        vc.linkText = self.image[indexPath.row].description //had to be chanched to link
        self.present(vc, animated: true, completion: nil) 
    }
}
