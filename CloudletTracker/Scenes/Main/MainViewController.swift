//
//  MainViewController.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let updateButton = ActionButton()
    private let temperatureStaticLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let pressureStaticLabel = UILabel()
    private let pressureLabel = UILabel()
    private let windStaticLabel = UILabel()
    private let windLabel = UILabel()
    private let sunriseStaticLabel = UILabel()
    private let sunriseLabel = UILabel()
    private let sunsetStaticLabel = UILabel()
    private let sunsetLabel = UILabel()
    private let threeDaysForecastTableView = ForecastTableView()
    private let threeDaysForecastTableViewAdapter = ForecastTableViewAdapter()

    var presenter: MainPresenter!

    override func loadView() {
        view = UIView()

        view.addSubview(updateButton)
        updateButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.width.height.equalTo(30.0)
        }
        view.addSubview(temperatureStaticLabel)
        temperatureStaticLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70.0)
            $0.leading.trailing.equalToSuperview().inset(40.0)
        }
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureStaticLabel.snp.bottom).offset(2.0)
            $0.centerX.equalToSuperview()
        }
        view.addSubview(pressureStaticLabel)
        pressureStaticLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(10.0)
            $0.trailing.equalTo(view.snp.centerX).offset(-50.0)
        }
        view.addSubview(pressureLabel)
        pressureLabel.snp.makeConstraints {
            $0.top.equalTo(pressureStaticLabel.snp.bottom).offset(2.0)
            $0.centerX.equalTo(pressureStaticLabel)
            $0.trailing.equalTo(temperatureStaticLabel.snp.centerX)
        }
        view.addSubview(windStaticLabel)
        windStaticLabel.snp.makeConstraints {
            $0.top.equalTo(pressureStaticLabel)
            $0.leading.equalTo(view.snp.centerX).offset(50.0)
        }
        view.addSubview(windLabel)
        windLabel.snp.makeConstraints {
            $0.top.equalTo(windStaticLabel.snp.bottom).offset(2.0)
            $0.leading.equalTo(temperatureStaticLabel.snp.centerX)
            $0.centerX.equalTo(windStaticLabel)
        }
        view.addSubview(sunriseStaticLabel)
        sunriseStaticLabel.snp.makeConstraints {
            $0.top.equalTo(pressureLabel.snp.bottom).offset(10.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        view.addSubview(sunriseLabel)
        sunriseLabel.snp.makeConstraints {
            $0.top.equalTo(sunriseStaticLabel)
            $0.leading.equalTo(sunriseStaticLabel.snp.trailing).offset(5.0)
        }
        view.addSubview(sunsetStaticLabel)
        sunsetStaticLabel.snp.makeConstraints {
            $0.top.equalTo(sunriseStaticLabel)
            $0.leading.equalTo(view.snp.centerX).offset(16.0)
        }
        view.addSubview(sunsetLabel)
        sunsetLabel.snp.makeConstraints {
            $0.top.equalTo(sunsetStaticLabel)
            $0.leading.equalTo(sunsetStaticLabel.snp.trailing).offset(5.0)
        }
        view.addSubview(threeDaysForecastTableView)
        threeDaysForecastTableView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        updateButton.touchUpInside = { [weak self] in
            self?.presenter.handleUpdateButtonPress()
        }
        updateButton.setImage(UIImage(named: "update_icon"), for: .normal)

        temperatureStaticLabel.textColor = .gray
        temperatureStaticLabel.textAlignment = .center
        temperatureStaticLabel.font = .regularFont(ofSize: 14.0)

        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .black
        temperatureLabel.font = .boldFont(ofSize: 30.0)

        pressureStaticLabel.textColor = .gray
        pressureStaticLabel.textAlignment = .center
        pressureStaticLabel.font = .regularFont(ofSize: 14.0)

        pressureLabel.textAlignment = .center
        pressureLabel.textColor = .black
        pressureLabel.font = .boldFont(ofSize: 16.0)

        windStaticLabel.textColor = .gray
        windStaticLabel.textAlignment = .center
        windStaticLabel.font = .regularFont(ofSize: 14.0)

        windLabel.textAlignment = .center
        windLabel.textColor = .black
        windLabel.font = .boldFont(ofSize: 16.0)

        sunriseStaticLabel.textAlignment = .left
        sunriseStaticLabel.textColor = .gray
        sunriseStaticLabel.font = .regularFont(ofSize: 14.0)

        sunriseLabel.textAlignment = .left
        sunriseLabel.textColor = .black
        sunriseLabel.font = .boldFont(ofSize: 16.0)

        sunsetStaticLabel.textAlignment = .left
        sunsetStaticLabel.textColor = .gray
        sunsetStaticLabel.font = .regularFont(ofSize: 14.0)

        sunsetLabel.textAlignment = .left
        sunsetLabel.textColor = .black
        sunsetLabel.font = .boldFont(ofSize: 16.0)

        threeDaysForecastTableView.delegate = threeDaysForecastTableViewAdapter
        threeDaysForecastTableView.dataSource = threeDaysForecastTableViewAdapter

        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension MainViewController: MainView {
    func display(temperatureStaticTitle: String) {
        temperatureStaticLabel.text = temperatureStaticTitle
    }

    func display(temperature: String) {
        temperatureLabel.text = temperature
    }

    func display(pressureStaticTitle: String) {
        pressureStaticLabel.text = pressureStaticTitle
    }

    func display(pressure: String) {
        pressureLabel.text = pressure
    }

    func display(windStaticTitle: String) {
        windStaticLabel.text = windStaticTitle
    }

    func display(windSpeed: String) {
        windLabel.text = windSpeed
    }

    func display(sunriseStaticTitle: String) {
        sunriseStaticLabel.text = sunriseStaticTitle
    }

    func display(sunriseTime: String) {
        sunriseLabel.text = sunriseTime
    }

    func display(sunsetStaticTitle: String) {
        sunsetStaticLabel.text = sunsetStaticTitle
    }

    func display(sunsetTime: String) {
        sunsetLabel.text = sunsetTime
    }

    func display(threeDaysForecastItems: [ForecastTableViewItem]) {
        threeDaysForecastTableViewAdapter.updateForecastItems(threeDaysForecastItems)
        threeDaysForecastTableView.reloadData()
    }
}
