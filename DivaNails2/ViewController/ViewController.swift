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
        super.viewDidLoad()
        downloadJson()
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadJson()
    {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL){ data, URLResponse, error in
            guard let data = data, error == nil, URLResponse != nil else
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell") as? CategoryCellTableViewCell else { return UITableViewCell()}
        
        cell.ColorLabel.text = category[indexPath.row].name
        return cell
    }
}

