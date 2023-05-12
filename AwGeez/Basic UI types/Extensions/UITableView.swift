//
//  UITableView.swift
//  AwGeez
//
//  Created by Tony Dэ on 27.04.2023.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: TableViewCell>(with type: T.Type) -> T {
        let reuseIdentifier = String(describing: type.self)
        self.register(T.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
        return self.dequeueReusableCell(withIdentifier: reuseIdentifier) as! T // swiftlint:disable:this force_cast
    }
}
