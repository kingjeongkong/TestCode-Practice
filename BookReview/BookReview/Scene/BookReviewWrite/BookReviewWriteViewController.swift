//
//  BookReviewWriteViewController.swift
//  BookReview
//
//  Created by 왕정빈 on 9/3/24.
//

import UIKit
import SnapKit
import Kingfisher

final class BookReviewWriteViewController: UIViewController {
    
    private lazy var presenter = BookReviewWritePresenter(delegate: self)
    
    private lazy var bookTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23, weight: .bold)
        button.addTarget(self, action: #selector(didTapBookTitleButton), for: .touchUpInside)
        return button
    }()
    private lazy var contentsTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .tertiaryLabel
        textView.text = "내용을 입력해주세요."
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        textView.delegate = self
        return textView
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension BookReviewWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == UIColor.tertiaryLabel else {
            return
        }
        
        textView.text = nil
        textView.textColor = .label
    }
}

extension BookReviewWriteViewController: BookReviewWriteProtocol {
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, 
                                                           target: self,
                                                           action: #selector(didTapLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(didTapRightBarButton))
    }
    
    func showCloseAlertSheet() {
        let alertController = UIAlertController(title: "작성중인 내용이 있습니다. 정말 닫으시겠습니까?",
                                                message: nil,
                                                preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "닫기",
                                        style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .cancel)
        
        [closeAction, cancelAction].forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
    
    func close() {
        dismiss(animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        [bookTitleButton, contentsTextView, imageView]
            .forEach { view.addSubview($0) }
        
        bookTitleButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        contentsTextView.snp.makeConstraints {
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(contentsTextView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(contentsTextView)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
    }
    
    func presentToSearchBookViewController() {
        let vc = UINavigationController(rootViewController: SearchBookViewController(searchBookDelegate: presenter))
        present(vc, animated: true)
    }
    
    func updateViews(title: String, imageURL: URL?) {
        bookTitleButton.setTitle(title, for: .normal)
        bookTitleButton.setTitleColor(.label, for: .normal)
        imageView.kf.setImage(with: imageURL)
    }
}

private extension BookReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton(contentsText: contentsTextView.text)
    }
    
    @objc func didTapBookTitleButton() {
        presenter.didTapBookTitleButton()
    }
}
