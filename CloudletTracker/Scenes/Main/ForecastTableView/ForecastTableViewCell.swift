//
//  ForecastTableViewCell.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

extension ForecastTableViewCell: ReuseIdentifiable { }

final class ForecastTableViewCell: UITableViewCell {
    private let contentMargins = UIEdgeInsets(top: 1.0, left: 0.0, bottom: 0.0, right: 4.0)

    private let content = ForecastTableContentView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = .lightGray
        self.selectionStyle = .none

        self.contentView.addSubview(self.content)
        self.content.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(self.contentMargins)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        content.dateLabel.text = nil
        content.temperatureLabel.text = nil
    }

    func display(item: ForecastTableViewItem) {
        content.dateLabel.text = item.date
        content.temperatureLabel.text = item.temperature
    }
}
