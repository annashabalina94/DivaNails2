//
//  ViewController.swift
//  DivaNails2
//
//  Created by Anna Shabalina on 10/31/17.
//  Copyright © 2017 Anna Shabalina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource
{

    let url = URL(string: "http://13.82.186.151:4040/categories")
    private var category = [Category]()
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad()
    {
        
        downloadJson()
        tableView.tableFooterView = UIView()
        super.viewDidLoad()
        
    }

    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        animateTable()
        
    }
    
    
    func downloadJson()
    {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, URLResponse, error in
            guard let data = data, error == nil, URLResponse != nil
                else
            {
                print("Something is wrong")
                return
            }
            print("downloaded")
            do
            {
                let decoder = JSONDecoder()
                let downloadedCategory = try decoder.decode([Category].self, from: data)
                self.category = downloadedCategory
                DispatchQueue.main.async
                    {
                        self.tableView.reloadData()
                    }
            }
            catch
            {
                print("Something wrong after downloading")
            }
            }.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return category.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell") as? CategoryCellTableViewCell else { return UITableViewCell()}
        
        cell.ColorLabel.text = category[indexPath.row].name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)/////////
    {
        print("User tapped on item \(indexPath.row)")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let indexPath = tableView.indexPathForSelectedRow
        {
            if segue.destination is ImageViewController
            {
                let vc = segue.destination as? ImageViewController
                vc?.id = self.category[indexPath.row].categoryId
            }
        }
    }
    
    
    func animateTable()
    {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        for cell in cells
        {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells
        {
            UIView.animate (withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
}

