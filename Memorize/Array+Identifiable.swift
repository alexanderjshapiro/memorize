//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/28/20.
//

import Foundation

extension Array where Element: Identifiable {
    func index(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
