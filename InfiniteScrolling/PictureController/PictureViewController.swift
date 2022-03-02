//
//  PictureViewController.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 14.02.2021.
//

import UIKit

class PictureViewController: UIViewController {
    var item: Item? {
        didSet {
            guard let item = item else { return }
            if let bigImage = item.bigImage {
                photoImageView.image = bigImage
            } else {
                if let smallImage = item.smallImage {
                    photoImageView.image = smallImage
                } else {
                    photoImageView.image = UIImage(named: "broken")
                }
            }
            downloadDateTimeLabel.text = "Download date: " + item.downloadDate.datetimeToString()
        }
    }
    
    /// Picture (photo)
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()
    
    /// Download date+time
    private lazy var downloadDateTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(photoImageView)
        view.addSubview(downloadDateTimeLabel)

        let safe = view.safeAreaLayoutGuide
        let constraints = [
            photoImageView.topAnchor.constraint(equalTo: safe.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -40),
            downloadDateTimeLabel.heightAnchor.constraint(equalToConstant:20),
            downloadDateTimeLabel.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            downloadDateTimeLabel.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
