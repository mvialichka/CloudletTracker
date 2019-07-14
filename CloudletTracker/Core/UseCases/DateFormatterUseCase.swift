//
//  DateFormatterUseCase.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import Foundation

protocol DateFormatterUseCase {
    func format(date: Date) -> String
    func format(date: Date, format: String) -> String
    func format(value: String, format: String) -> String?
    func createDate(from value: String) -> Date?
    func format(milliseconds: Int) -> String
}

final class DateFormatterUseCaseImpl: DateFormatterUseCase {
    private static let defaultFormat = "dd.MM.yyyy"

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = defaultFormat
        return formatter
    }()

    func format(date: Date) -> String {
        let formatter = DateFormatterUseCaseImpl.dateFormatter
        return formatter.string(from: date)
    }

    func format(date: Date, format: String) -> String {
        let formatter = DateFormatterUseCaseImpl.dateFormatter
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    func format(value: String, format: String) -> String? {
        let formatter = DateFormatterUseCaseImpl.dateFormatter
        formatter.dateFormat = format
        guard let date = formatter.date(from: value) else {
            return nil
        }
        formatter.dateFormat = "dd.MM.yyyy hh:mm"
        return formatter.string(from: date)
    }

    func createDate(from value: String) -> Date? {
        let formatter = DateFormatterUseCaseImpl.dateFormatter
        return formatter.date(from: value)
    }

    func format(milliseconds: Int) -> String {
        let formatter = DateFormatterUseCaseImpl.dateFormatter
        let date = Date(timeIntervalSince1970: Double(milliseconds))
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: date)
    }
}
