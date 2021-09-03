//
//  CounterTests.swift
//  MoxturePracticeTests
//
//  Created by Hanyu on 2021/9/1.
//

import XCTest
@testable import MoxturePractice
import Moxture

class CounterTests: XCTestCase {
    func testCounterCheckoutWithCart() {
        // Given
        let client = SpyClient()
        let sut = Counter(client: client)

        // When
        let cart = Cart(items: [], price: 0, discount: 0, note: "", includeTax: true)
        sut.checkout(with: cart)

        // Then
        XCTAssertEqual(client.placeAnOrderFunc.args?.0, cart)
    }

    func testCounterCheckoutWithCartWithFixturable() {
        // Given
        let client = SpyClient()
        let sut = Counter(client: client)

        // When
        sut.checkout(with: .fixture)

        // Then
        XCTAssertEqual(client.placeAnOrderFunc.args?.0, .fixture)
    }

    func testCounterCheckoutWithCartWithFixturable2() {
        // Given
        let client = SpyClient()
        let sut = Counter(client: client)

        // When
        let cart: Cart = .fixture { cart in
            cart.discount = 100
        }
        sut.checkout(with: cart)

        // Then
        XCTAssertEqual(client.placeAnOrderFunc.args?.0, cart)
    }

    func testCounterCheckoutWithCartWithFixturable3() {
        // Given
        let client = SpyClient()
        let sut = Counter(client: client)

        // When
        sut.checkout(with: .fixture(label: "1"))

        // Then
        XCTAssertEqual(client.placeAnOrderFunc.args?.0, .fixture(label: "1"))
        // Demo only
        XCTAssertNotEqual(client.placeAnOrderFunc.args?.0, .fixture(label: "2"))
    }
}


final class SpyClient: Client {

    private(set) lazy var placeAnOrderFunc = FuncMock(self.placeAnOrder)
    func placeAnOrder(with cart: Cart, completion: @escaping (Result<Data, Error>) -> Void) {
        placeAnOrderFunc.call((cart, completion))
    }
}

extension Cart: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.items == rhs.items &&
            lhs.price == rhs.price &&
            lhs.discount == rhs.discount &&
            lhs.note == rhs.note &&
            lhs.includeTax == rhs.includeTax
    }
}

extension Cart: Fixturable {
    public static func fixture(label: String, configure: (inout Cart) -> Void) -> Cart {
        makeFixture(label, configure, {
            Cart(
                items: .fixture(label: label),
                price: .fixture(label: label),
                discount: .fixture(label: label),
                note: .fixture(label: label),
                includeTax: .fixture(label: label)
            )
        })
    }
}
