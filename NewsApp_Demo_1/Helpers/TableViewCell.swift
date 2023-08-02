//
//  TableViewCell.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {

    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }

    weak var delegate: NSObjectProtocol?

    func configure(_ item: Any?) {

    }

}


class TableHeaderFooterView: UITableViewHeaderFooterView {

    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }

    weak var delegate: NSObjectProtocol?

    func configure(_ item: Any?) {

    }
    
}

