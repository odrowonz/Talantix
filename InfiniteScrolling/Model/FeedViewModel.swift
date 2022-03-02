//
//  FeedViewModel.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 14.02.2021.
//

import Foundation
import UIKit

protocol FeedViewModel: AnyObject {
    // Get count of item's array
    func getCount() -> Int
    // Get item
    func getItem(_ i: Int) -> Item
    // Loading and saving list of items
    func getNextPage(_ refresh: @escaping((_ title: String)->Void))
}
