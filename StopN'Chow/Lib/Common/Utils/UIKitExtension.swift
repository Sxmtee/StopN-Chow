//
//  UIKitExtension.swift
//  StopN'Chow
//
//  Created by mac on 27/02/2025.
//

import Foundation

extension String {
    func stringDateToDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let dataFormat = DateFormatter()
        dataFormat.dateFormat = format
        return dataFormat.date(from: self)
    }
}
