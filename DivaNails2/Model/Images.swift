//
//  Images.swift
//  DivaNails2
//
//  Created by Anna Shabalina on 10/31/17.
//  Copyright © 2017 Anna Shabalina. All rights reserved.
//

import UIKit

class Images: Codable
{
    let small: String
    let large: String
    let description: String
    
    init (small: String, large: String, description: String)
    {
        self.small = small
        self.large = large
        self.description = description
    }

}
