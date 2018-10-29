//
//  BookSeatsViewController.swift
//  Mission X
//
//  Created by Daniel Vebman on 10/28/18.
//  Copyright © 2018 Daniel Vebman. All rights reserved.
//

import Foundation
import UIKit

class BookSeatsViewController: UIViewController {
    var seatsLayout: [[Bool]] = [
               [true,  true,  true,  true ],
               [true,  false, false, true ],
               [true,  true , true,  false],
        [true,  true,  true,  false, false, false],
        [true,  false, true,  false, false, false],
        [true,  true,  false, false, false, false],
        [true,  true,  false, false, false, false],
        [true,  true,  false, false, false, false],
        [true,  true,  false, false, false, true ],
        [true,  false, false, false, false, true ],
        [false, false, false, false, true,  false],
        [false, false, false, false, false, false],
        [false, false, false, false, false, false],
        [false, false, false, false, false, false]
    ]
    
    override func viewDidLoad() {
        
    }
}
