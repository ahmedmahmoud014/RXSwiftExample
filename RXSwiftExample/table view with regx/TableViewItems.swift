//
//  TableViewItems.swift
//  RXSwiftExample
//
//  Created by mac bokk pro on 2018-11-12.
//  Copyright © 2018 mac bokk pro. All rights reserved.
//

import Foundation
import RxSwift

class TableViewItems{
     static let shard =  TableViewItems()
    init(){}

    var allItems : Variable<[String]> = Variable([])

}
