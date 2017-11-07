//
//  Category.swift
//  DivaNails2
//
//  Created by Anna Shabalina on 10/31/17.
//  Copyright © 2017 Anna Shabalina. All rights reserved.
//

import UIKit

class Category: Codable
{
    let categoryId: String
    let name: String
    
    init(categoryId: String, name: String)
    {
        self.categoryId = categoryId
        self.name = name
    }
}
