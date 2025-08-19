//
//  SimpleTableViewExerciseViewController.swift
//  SeSACWeek8_day2_Assignment
//
//  Created by 박현진 on 8/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SimpleTableViewExerciseViewController: UIViewController {

    let tableView = {
        let tableView = UITableView()
        tableView.register(SimpleTableViewExampleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewExampleTableViewCell.identifier)
        return tableView
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        let items = Observable.just(
            (0..<20).map {
                "\($0)"
            }
        )
        
        items.bind(to: tableView.rx.items(cellIdentifier: SimpleTableViewExampleTableViewCell.identifier, cellType: SimpleTableViewExampleTableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = "\(element) @ row \(row)"
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe { value in
                DefaultWireframe.presentAlert("Tapped '\(value)'")
            }
            .disposed(by: disposeBag)

        tableView.rx.itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
                print("악세사리 클릭?")
        })
            .disposed(by: disposeBag)
        
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
