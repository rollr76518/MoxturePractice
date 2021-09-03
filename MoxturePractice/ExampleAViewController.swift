//
//  ExampleAViewController.swift
//  MoxturePractice
//
//  Created by Hanyu on 2021/9/3.
//

import UIKit

protocol DataProviding {
    func cancel()
    func loadImageData(from url: URL) throws -> Data
    func fetch(completion: @escaping (Result<[Data], Error>) -> Void)
}

class ExampleAViewController: UIViewController {
    private let dataProvider: DataProviding

    init(dataProvider: DataProviding) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.fetch { _ in
            // Do something
        }

        let url = URL(string: "https://anyURL")!
        _ = try? dataProvider.loadImageData(from: url)

        dataProvider.cancel()
    }
}
