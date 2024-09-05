//
//  SearchBookPresenter.swift
//  BookReview
//
//  Created by 왕정빈 on 9/4/24.
//

import UIKit

protocol SearchBookProtocol {
    func setupViews()
    func dismiss()
    func reloadView()
}

protocol SearchBookDelegate {
    func selectBook(_ book: Book)
}

final class SearchBookPresenter: NSObject {
    private let viewController: SearchBookProtocol
    private let bookSearchManager = BookSearchManager()
    
    private let delegate: SearchBookDelegate
    
    private var books: [Book] = []
    
    init(viewController: SearchBookProtocol, delegate: SearchBookDelegate) {
        self.viewController = viewController
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        viewController.setupViews()
    }
}

extension SearchBookPresenter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        bookSearchManager.request(with: searchText) { [weak self] books in
            self?.books = books
            self?.viewController.reloadView()
        }
    }
}

extension SearchBookPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = books[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        delegate.selectBook(selectedBook)
        viewController.dismiss()
    }
}
