//
//  SimpleTableViewExampleTableViewCell.swift
//  SeSACWeek8_day2_Assignment
//
//  Created by 박현진 on 8/19/25.
//

import UIKit
import SnapKit


class SimpleTableViewExampleTableViewCell: UITableViewCell {

   static let identifier = "SimpleTableViewExampleTableViewCell"
    
    let simpleTextLabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(simpleTextLabel)
        simpleTextLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }

    }

}
