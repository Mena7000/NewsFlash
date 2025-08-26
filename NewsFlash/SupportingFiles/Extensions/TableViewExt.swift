//
//  TableViewExt.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit

public extension UITableView {
    func registerCellNib(withIdentifier identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}
