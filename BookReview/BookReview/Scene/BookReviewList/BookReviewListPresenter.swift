//
//  BookReviewListPresenter.swift
//  BookReview
//
//  Created by 왕정빈 on 9/2/24.
//

import UIKit

protocol BookReviewListProtocol {
    func setupNavigationBar()
    func setupViews()
}

final class BookReviewListPresenter: NSObject {
    private let delegate: BookReviewListProtocol
    
    init(delegate: BookReviewListProtocol) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        delegate.setupNavigationBar()
        delegate.setupViews()
    }
}

extension BookReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        var content = cell.defaultContentConfiguration()
        content.text = "\(indexPath)"
        cell.contentConfiguration = content
        return cell
    }
    
    
}
