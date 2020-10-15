//
//  UITableView+Cell.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeuCellOfType<Cell: UITableViewCell>(_ type: Cell.Type) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.identifier) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.identifier)")
        }
        return cell
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: UINibable {
    static func uiNib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
