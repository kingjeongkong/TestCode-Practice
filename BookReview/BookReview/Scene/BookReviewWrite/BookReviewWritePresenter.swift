//
//  BookReviewWritePresenter.swift
//  BookReview
//
//  Created by 왕정빈 on 9/3/24.
//

import Foundation

protocol BookReviewWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertSheet()
    func close()
    func setupViews()
    func presentToSearchBookViewController()
    func updateViews(title: String, imageURL: URL?)
}

final class BookReviewWritePresenter {
    private let delegate: BookReviewWriteProtocol
    private let userDefaultsManager = UserDefaultManager()
    
    private var book: Book?
    
    init(delegate: BookReviewWriteProtocol) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        delegate.setupNavigationBar()
        delegate.setupViews()
    }
    
    func didTapLeftBarButton() {
        delegate.showCloseAlertSheet()
    }
    
    func didTapRightBarButton(contentsText: String?) {
        guard let book = book else { return }
        let bookReview = BookReview(title: book.title, contents: contentsText ?? "", imageURL: book.imageURL)
        userDefaultsManager.setReview(bookReview)
        delegate.close()
    }
    
    func didTapBookTitleButton() {
        delegate.presentToSearchBookViewController()
    }
}

extension BookReviewWritePresenter: SearchBookDelegate {
    func selectBook(_ book: Book) {
        self.book = book
        delegate.updateViews(title: book.title, imageURL: book.imageURL)
    }
}
