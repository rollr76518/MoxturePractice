//
//  ExampleBViewControllerTests.swift
//  MoxturePracticeTests
//
//  Created by Hanyu on 2021/9/3.
//

import XCTest
@testable import MoxturePractice
import Moxture

class ExampleBViewControllerTests: XCTestCase {

    func testViewController_viewDidLoad_readTheStore() {
        // Given
        let store = MockStore()
        let sut = ExampleBViewController(store: store)

        // When
        sut.loadViewIfNeeded()

        // Then
        XCTAssertEqual(store.data, [10, 0])
    }

    func testViewController_viewDidLoad_readTheStoreWithPropMock() {
        // Given
        let store = PropMockStore()
        let sut = ExampleBViewController(store: store)
        store.dataProp.returns = [10]

        // When
        sut.loadViewIfNeeded()

        // Then
        XCTAssertEqual(store.dataProp.set.args, [10, 0])
    }
}

final class MockStore: DataStore {
    var data: [Int] = [10]
}


final class PropMockStore: DataStore {
    lazy var dataProp = PropMock(\PropMockStore.data)
    var data: [Int] {
        get { dataProp.get.call() }
        set { dataProp.set.call(newValue) }
    }
}
