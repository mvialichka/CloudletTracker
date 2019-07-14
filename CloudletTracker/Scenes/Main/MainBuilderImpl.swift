//
//  MainBuilderImpl.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

final class MainBuilderImpl: MainBuilder {
    private let dependency: MainDependency

    init(dependency: MainDependency) {
        self.dependency = dependency
    }

    func build(listener: MainListener) -> MainCoordinator {
        let view = MainViewController()
        let router = MainRouterImpl(listener: listener)
        let coordinator = MainCoordinatorImpl(parent: dependency.parent, view: view)
        let wheatherAPI: APIProvider<WeatherAPI> = .cloudletTrackerNetworking(tokenHolder: dependency.tokenHolder)
        let localStorage = LocalStorage()
        let repository = MainRepositoryImpl(wheatherAPI: wheatherAPI)
        let locationUseCase = GeolocationUseCase()
        let dayForecastMapper = DayForecastMapper()
        let dateFormatterUseCase = DateFormatterUseCaseImpl()
        let interactor = MainInteractorImpl(
            mainRepository: repository,
            locationUseCase: locationUseCase,
            localStorage: localStorage
        )
        let presenter = MainPresenterImpl(
            view: view,
            router: router,
            dateFormatterUseCase: dateFormatterUseCase,
            dayForecastMapper: dayForecastMapper,
            mainInteractor: interactor
        )
        view.presenter = presenter
        return coordinator
    }
}
