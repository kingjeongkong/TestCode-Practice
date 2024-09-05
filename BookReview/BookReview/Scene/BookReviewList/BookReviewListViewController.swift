//
//  BookReviewListViewController.swift
//  BookReview
//
//  Created by 왕정빈 on 9/2/24.
//

import UIKit
import SnapKit

final class BookReviewListViewController: UIViewController {

    private lazy var presenter = BookReviewListPresenter(delegate: self)
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}

extension BookReviewListViewController: BookReviewListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "도서 리뷰"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                 target: self,
                                                 action: #selector(didTapRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func presentToReviewWriteViewController() {
        let vc = UINavigationController(rootViewController: BookReviewWriteViewController())
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

private extension BookReviewListViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}
