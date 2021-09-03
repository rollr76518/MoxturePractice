//
//  Counter.swift
//  MoxturePractice
//
//  Created by Hanyu on 2021/9/1.
//

import Foundation

struct Cart: Codable {
    var items: [String]
    var price: Decimal
    var discount: Decimal
    var note: String
    var includeTax: Bool
}

protocol Client {
    func placeAnOrder(with cart: Cart, completion: @escaping (Result<Data, Error>) -> Void)
}

final class Counter {

    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func checkout(with cart: Cart) {
        //Do something
        client.placeAnOrder(with: cart) { _ in
            //Do something
        }
    }
}
