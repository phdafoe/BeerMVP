//  Date+Extensions.swift
//  Architecture MVP
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation
import UIKit

extension Date {
    func format(format: String = Helpers.Constants.presentationDateFormat) -> String {
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = format

		return dateFormatter.string(from: self)
	}

	func byAdding(component: Calendar.Component, value: Int) -> Date {
		return Calendar.current.date(byAdding: component, value: value, to: self)!
	}

	var yesterday: Date {
		return Calendar.current.date(byAdding: .day, value: -1, to: self)!
	}

	var day: Int {
		return Calendar.current.component(.day, from: self)
	}

	var tomorrow: Date {
		return Calendar.current.date(byAdding: .day, value: +1, to: self)!
	}

	var month: Int {
		return Calendar.current.component(.month, from: self)
	}

	var year: Int {
		return Calendar.current.component(.year, from: self)
	}

	var lastMonth: Int {
		return month - 1
	}

	var yesterdayMonth: Int {
		return Calendar.current.component(.month, from: yesterday)
	}

	var firstDayMonth: Date {
		let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: self)
		let startOfMonth = Calendar.current.date(from: comp)!
		return startOfMonth
	}

	var lastDayMonth: Date {
		let year = Calendar.current.component(.year, from: self)
		let comp = DateComponents(calendar: Calendar.current, year: year, month: month + 1)
		let startDayOfNexMonth = Calendar.current.date(from: comp)!
		let lastDayMonth = startDayOfNexMonth.yesterday
		return lastDayMonth
	}

	var firstDayOfYesterdayMonth: Date {
		return yesterday.firstDayMonth
	}

	public static func createDate(day: Int,
								  month: Int,
								  year: Int) -> Date {
		return Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
	}

	var mondayOfFirstWeekOfMonth: Date {
		let calendar = Calendar.current
		// Convertimos los indices de la semana por defecto Domingo 1, Lunes 2...Sabado 7 a Lunes 1, Martes 2... Domingo 7
		var dayOfWeek = calendar.component(.weekday, from: firstDayMonth) + 1 - calendar.firstWeekday
		if dayOfWeek <= 0 {
			dayOfWeek += 7
		}

		// Le restamos 1 al indice que nos de para luego restar tantos numeros de dias como valor nos resulte este weekIndex a self
		let weekIndex = dayOfWeek - 1

		return Calendar.current.date(byAdding: .day, value: -abs(weekIndex), to: firstDayMonth)!
	}

	var sundayOfLastWeekOfMonth: Date {
		let calendar = Calendar.current
		// Convertimos los indices de la semana por defecto Domingo 1, Lunes 2...Sabado 7 a Lunes 1, Martes 2... Domingo 7
		var dayOfWeek = calendar.component(.weekday, from: lastDayMonth) + 1 - calendar.firstWeekday
		if dayOfWeek <= 0 {
			dayOfWeek += 7
		}

		// Le restamos 1 al indice que nos de para luego sumar tantos numeros de dias como valor nos resulte este weekIndex a self

		let weekIndex = 7 - dayOfWeek

		return Calendar.current.date(byAdding: .day, value: +abs(weekIndex), to: lastDayMonth)!
	}

	static func getDateOfIndexMonth(monthIndex: Int) -> Date {
		let year = Calendar.current.component(.year, from: Date())
		let comp = DateComponents(calendar: Calendar.current, year: year, month: monthIndex)
		return Calendar.current.date(from: comp)!
	}

	var startOfWeek: Date? {
		let gregorian = Calendar(identifier: .iso8601)
		guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
		return gregorian.date(byAdding: .day, value: 1, to: sunday)
	}

	static var currentWeek: [Date] {
		let calendar = Calendar.current
		let weekdayOrdinal = calendar.component(.weekdayOrdinal, from: Date(timeIntervalSinceNow: 0))
		print(weekdayOrdinal)
		guard let firstDay = Date().startOfWeek else { return [] }
		var week: [Date] = []
		for index in 0 ... 7 {
			week.append(firstDay + index)
		}

		return week
	}

	static var currentMonth: [Date] {
		guard var firstDay = Date().startOfWeek else { return [] }
		firstDay = firstDay.yesterday
		var week: [Date] = []
		for index in 0 ... 27 {
			week.append(firstDay + index)
		}

		return week
	}

	static func + (left: Date, right: Int) -> Date {
		return left.byAdding(component: .day, value: right)
	}

	func dayNumberOfWeek() -> Int? {
		return (Calendar.current.dateComponents([.weekday], from: self).weekday ?? 0)
	}

	func isToday() -> Bool {
		return format(format: "dd/MM/yyyy") == Date().format(format: "dd/MM/yyyy")
	}

	func isYesterday() -> Bool {
		return format(format: "dd/MM/yyyy") == Date().yesterday.format(format: "dd/MM/yyyy")
	}
}
