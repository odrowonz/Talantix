//
//  FeedViewController.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 11.02.2021.
//

import UIKit

enum MaxCountOfItemsInSection: Int {
    case vertical = 3
    case horizontal = 4
}

class FeedViewController: UIViewController {    
    // How many maximum cells should fit in a section
    private var maxCountOfItemsInSection: Int {
        didSet {
            if let layout = self.collectionView.collectionViewLayout as? CustomCollectionViewFlowLayout {
                layout.numberOfItemsPerRow = maxCountOfItemsInSection
            }
        }
    }
    
    // Collection
    private lazy var collectionView: UICollectionView = {
        // Define the layer
        let layout = CustomCollectionViewFlowLayout()
        layout.numberOfItemsPerRow = maxCountOfItemsInSection
        layout.scrollDirection = .vertical
        // Create a collection with a zero frame and a previously defined layer
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Register cell classes
        // Image cell
        collectionView.register(FeedCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: FeedCollectionViewCell.self))
        // Loading cell
        collectionView.register(LoadingCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: LoadingCollectionViewCell.self))

        // Align everything
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // White background
        collectionView.backgroundColor = .white

        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()
    
    private var viewmodel: FeedViewModel

    var loadingView: LoadingCollectionViewCell?

    var isLoading = false
    
    init(maxCountOfItemsInSection: Int, viewmodel: FeedViewModel) {
        self.maxCountOfItemsInSection = maxCountOfItemsInSection
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Flickr cars"
        let gest = UILongPressGestureRecognizer(target: self, action: #selector(loadMoreData))
        self.navigationController?.navigationBar.addGestureRecognizer(gest)

        setupLayout()
        
        loadMoreData()
    }
    
    @objc
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            self.collectionView.collectionViewLayout.invalidateLayout()
            
            viewmodel.getNextPage {
                [weak self]
                (title: String)
                in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.isLoading = false
                    self.navigationController?.navigationBar.topItem?.title = title
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func setupLayout() {
        view.addSubview(collectionView)

        let safe = view.safeAreaLayoutGuide
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            maxCountOfItemsInSection = MaxCountOfItemsInSection.horizontal.rawValue
        } else {
            maxCountOfItemsInSection = MaxCountOfItemsInSection.vertical.rawValue
        }
    }
}
    
extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.getCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FeedCollectionViewCell.self), for: indexPath) as? FeedCollectionViewCell else { return UICollectionViewCell() }

        cell.item = viewmodel.getItem(indexPath.row)
        cell.itemNumberLabel.text =  "\(indexPath.row + 1) из \(viewmodel.getCount())"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewmodel.getCount() - 10 && !self.isLoading {
            DispatchQueue.main.async {
                [weak self] in
                guard let self = self else { return }
                self.loadMoreData()
            }
        }
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            if !self.isLoading {
                return CGSize.zero
            } else {
                return CGSize(width: collectionView.bounds.size.width, height: 55)
            }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: LoadingCollectionViewCell.self), for: indexPath) as? LoadingCollectionViewCell else { return UICollectionReusableView() }
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        } else { return UICollectionReusableView() }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
            if elementKind == UICollectionView.elementKindSectionFooter {
                self.loadingView?.loadingIndicator.startAnimating()
            }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
            if elementKind == UICollectionView.elementKindSectionFooter {
                self.loadingView?.loadingIndicator.stopAnimating()
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PictureViewController()
        vc.item = viewmodel.getItem(indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
