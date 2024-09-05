//
//  BookSearchManager.swift
//  BookReview
//
//  Created by 왕정빈 on 9/4/24.
//

import Foundation
import Alamofire

struct BookSearchManager {
    func request(with keyword: String, _ completion: @escaping (([Book]) -> Void)) {
        let url = URL(string: "https://openapi.naver.com/v1/search/book.json")!
        
        let parameters = BookSearchRequest(query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "Ckr73u6XFfTV0Ob8LnOT",
            "X-Naver-Client-Secret": "e1FcnuuQp0"
        ]
        
        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookSearchResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}

