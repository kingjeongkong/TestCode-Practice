//
//  BookReviewTests.swift
//  BookReviewTests
//
//  Created by 왕정빈 on 9/2/24.
//

import XCTest
@testable import BookReview

final class ReviewListPresenterTests: XCTestCase {
    var sut: BookReviewListPresenter!
    var viewController: MockReviewListViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockReviewListViewController()
        sut = BookReviewListPresenter(delegate: viewController)
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledNavigationBar)
        XCTAssertTrue(viewController.isCalledsetupViews)
    }
}

final class MockReviewListViewController: BookReviewListProtocol {
    var isCalledNavigationBar = false
    var isCalledsetupViews = false
    var isCalledpresentToReviewWriteViewController = false
    var isCalledreloadTableView = false
    
    func setupNavigationBar() {
        isCalledNavigationBar = true
    }
    
    func setupViews() {
        isCalledsetupViews = true
    }
    
    func presentToReviewWriteViewController() {
        isCalledpresentToReviewWriteViewController = true
    }
    
    func reloadTableView() {
        isCalledreloadTableView = true
    }
}
