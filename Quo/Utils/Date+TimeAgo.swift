//
//  Date+TimeAgo.swift
//  Quo
//
//  Created by Federico Trimboli on 30/04/2018.
//

import Foundation

extension Date {
    fileprivate struct Item {
        let multi: String
        let single: String
        let value: Int?
    }
    
    fileprivate var components: DateComponents {
        return Calendar.current.dateComponents(
            [.second, .minute, .hour, .day, .weekOfYear, .month, .year],
            from: Calendar.current.date(byAdding: .second, value: -1, to: Date())!,
            to: self
        )
    }
    
    fileprivate var items: [Item] {
        return [
            Item(multi: "Hace %d años", single: "Hace 1 año", value: components.year),
            Item(multi: "Hace %d meses", single: "Hace 1 mes", value: components.month),
            Item(multi: "Hace %d semanas", single: "Hace 1 semana", value: components.weekOfYear),
            Item(multi: "Hace %d días", single: "Hace 1 día", value: components.day),
            Item(multi: "Hace %d horas", single: "Hace 1 hora", value: components.hour),
            Item(multi: "Hace %d minutos", single: "Hace 1 minuto", value: components.minute),
            Item(multi: "Hace %d segundos", single: "Recién ahora", value: components.second)
        ]
    }
    
    var timeAgo: String {
        for item in items {
            switch item.value {
            case let .some(step) where step == 0:
                continue
            case let .some(step) where step == 1:
                return item.single
            case let .some(step):
                return String(format: item.multi, -step)
            default:
                continue
            }
        }
        
        return "Recién ahora"
    }
}
