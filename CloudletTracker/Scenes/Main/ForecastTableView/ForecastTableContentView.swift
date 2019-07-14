//
//  ForecastTableContentView.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit
import SnapKit

final class ForecastTableContentView: UIView {
    let dateLabel = UILabel()
    let temperatureLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        self.dateLabel.textAlignment = .left
        self.dateLabel.textColor = .black
        self.dateLabel.font = .regularFont(ofSize: 12.0)
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.0)
            $0.leading.equalToSuperview().offset(10.0)
        }

        self.temperatureLabel.textAlignment = .left
        self.temperatureLabel.textColor = .black
        self.temperatureLabel.font = .boldFont(ofSize: 18.0)
        self.addSubview(self.temperatureLabel)
        self.temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(15.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
