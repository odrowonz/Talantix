//
//  CustomCollectionViewFlowLayout.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 14.02.2021.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    @IBInspectable var numberOfItemsPerRow: Int = 0 {
        didSet {
            invalidateLayout()
        }
    }
    
    override func prepare() {
        super.prepare()
        
        if let collectionView = self.collectionView {
            var newItemSize = itemSize
            
            // Always use an item count of at least 1 and convert it to a float to use in size calculations
            let itemsPerRow = CGFloat(max(numberOfItemsPerRow, 1))
            
            // Calculate the sum of the spacing between cells
            let totalSpacing = minimumInteritemSpacing * (itemsPerRow - 1.0)
            
            // Calculate how wide items should be
            newItemSize.width = (collectionView.bounds.size.width - sectionInset.left - sectionInset.right - totalSpacing) / itemsPerRow
            
            // Use the aspect ratio of the current item size to determine how tall the items should be
            if itemSize.height > 0 {
                newItemSize.height = newItemSize.width * 1.5
            }
            
            // Set the new item size
            itemSize = newItemSize
        }
    }
}
