//
//  TableViewController.swift
//  AwGeez
//
//  Created by Tony Dэ on 26.04.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Nib are unsupported")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
