//
//  TableView+ IndexPath.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 18.06.2022.
//

import UIKit

public extension UITableView {
  func indexPathForView(_ view: UIView) -> IndexPath? {
    let origin = view.bounds.origin
    let viewOrigin = self.convert(origin, from: view)
    let indexPath = self.indexPathForRow(at: viewOrigin)
    return indexPath
  }
}
