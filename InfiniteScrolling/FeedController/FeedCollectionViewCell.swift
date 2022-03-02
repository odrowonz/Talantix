//
//  FeedCollectionViewCell.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 11.02.2021.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    weak var model: FeedViewModel?
    
    var item: Item? {
        didSet {
            guard let item = item else { return }
            
            // set image
            if let smallImage = item.smallImage {
                photoImageView.image = smallImage
            } else {
                photoImageView.image = UIImage(named: "broken")
            }
            
            // set exif
            if let exif = item.exif {
                exifLabel.text = "\(exif)"
            } else {
                exifLabel.text = "Exif no"
            }
        }
    }
    
    /// Picture (photo)
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    /// Items's number
    lazy var itemNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .red
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    
    /// Exif
    private lazy var exifLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 4
        label.textAlignment = .left
        return label
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
        addSubview(photoImageView)
        addSubview(itemNumberLabel)
        addSubview(exifLabel)
        

        let constraints = [
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: exifLabel.topAnchor, constant: -5),
            exifLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            exifLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            exifLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            itemNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            itemNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
