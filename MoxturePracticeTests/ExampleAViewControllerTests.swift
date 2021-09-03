//
//  ExampleAViewControllerTests.swift
//  MoxturePracticeTests
//
//  Created by Hanyu on 2021/9/3.
//

import XCTest
@testable import MoxturePractice
import Moxture

class ExampleAViewControllerTests: XCTestCase {

    func testViewController_viewDidLoad_callTheMethods() {
        // Given
        let provider = SpyDataProvider()
        let sut = ExampleAViewController(dataProvider: provider)

        // When
        sut.loadViewIfNeeded()

        // Then
        XCTAssertEqual(provider.countOfCancelCalls, 1)
        XCTAssertEqual(provider.capturedLoadImageData, [URL(string: "https://anyURL")!])
        XCTAssertEqual(provider.capturedFetchCompletions.count, 1)
    }

    func testViewController_viewDidLoad_callTheMethodsWithFuncMock() {
        // Given
        let provider = FuncMockDataProvider()
        let sut = ExampleAViewController(dataProvider: provider)

        // When
        sut.loadViewIfNeeded()

        // Then
        XCTAssertTrue(provider.cancelFunc.called)
        XCTAssertEqual(provider.loadImageDataFunc.args, URL(string: "https://anyURL"))
        XCTAssertTrue(provider.fetchFunc.called)
    }
}

final class SpyDataProvider: DataProviding {
    private(set) var countOfCancelCalls: Int = 0
    func cancel() {
        countOfCancelCalls += 1
    }

    private(set) var capturedLoadImageData: [URL] = []
    func loadImageData(from url: URL) throws -> Data {
        capturedLoadImageData.append(url)
        return Data()
    }

    private(set) var capturedFetchCompletions: [(Result<[Data], Error>) -> Void] = []
    func fetch(completion: @escaping (Result<[Data], Error>) -> Void) {
        capturedFetchCompletions.append(completion)
        completion(.success([]))
    }
}

final class FuncMockDataProvider: DataProviding {
    private(set) lazy var cancelFunc = FuncMock(self.cancel)
    func cancel() {
        cancelFunc.call()
    }

    private(set) lazy var loadImageDataFunc = FuncMock(self.loadImageData)
    func loadImageData(from url: URL) throws -> Data {
        loadImageDataFunc.call(url)
    }

    private(set) lazy var fetchFunc = FuncMock(self.fetch)
    func fetch(completion: @escaping (Result<[Data], Error>) -> Void) {
        fetchFunc.call(completion)
    }
}
