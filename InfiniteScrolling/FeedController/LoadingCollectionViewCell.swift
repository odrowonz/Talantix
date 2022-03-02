//
//  LoadingCollectionViewCell.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 13.02.2021.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupLayout()
    }
    
    func setupLayout() {
        addSubview(loadingIndicator)

        let constraints = [
            loadingIndicator.widthAnchor.constraint(equalToConstant: 20),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 20),
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
