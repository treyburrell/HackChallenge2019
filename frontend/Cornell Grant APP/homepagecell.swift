//
//  homepagecell.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/22/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import Foundation
import UIKit

struct HomeGrant: Codable {
//    var Grantimage: UIImage? For the cells to have images rn i need this line, but i've only seen images shown through networking when the variable is a string that ends up being a url that houses an image. 
    var Grantname: String
    var Grantorg: String
    var Grantamt: String
    var Grantdue: String
    }

struct GrantResponse: Codable {
    var success: Bool
    var data: [HomeGrant]
}
