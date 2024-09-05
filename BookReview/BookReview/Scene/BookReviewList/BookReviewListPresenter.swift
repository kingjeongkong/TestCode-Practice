//
//  BookReviewListPresenter.swift
//  BookReview
//
//  Created by 왕정빈 on 9/2/24.
//

import UIKit
import Kingfisher

protocol BookReviewListProtocol {
    func setupNavigationBar()
    func setupViews()
    func presentToReviewWriteViewController()
    func reloadTableView()
}

final class BookReviewListPresenter: NSObject {
    private let delegate: BookReviewListProtocol
    private let userDefaultsManager = UserDefaultManager()
    
    private var reviews: [BookReview] = []
    
    init(delegate: BookReviewListProtocol) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        delegate.setupNavigationBar()
        delegate.setupViews()
    }
    
    func viewWillAppear() {
        reviews = userDefaultsManager.getReviews()
        delegate.reloadTableView()
    }
    
    func didTapRightBarButtonItem () {
        delegate.presentToReviewWriteViewController()
    }
}

extension BookReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = reviews[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = review.title
        content.secondaryText = review.contents
        cell.contentConfiguration = content
        
        let imageView = UIImageView()
        imageView.kf.setImage(with: review.imageURL) { _ in
            cell.setNeedsLayout()
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let imageSize: CGFloat = 40
        imageView.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        
        cell.accessoryView = imageView
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
