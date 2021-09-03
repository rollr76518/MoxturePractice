//
//  ExampleBViewController.swift
//  MoxturePractice
//
//  Created by Hanyu on 2021/9/3.
//

import UIKit

protocol DataStore {
    var data: [Int] { get set }
}

class ExampleBViewController: UIViewController {
    private var store: DataStore

    init(store: DataStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        store.data.append(0)
    }
}
