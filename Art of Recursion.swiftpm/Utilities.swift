//
//  Utilities.swift
//  Art of Recursion
//
//  Created by Don Chia on 14/4/22.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension Int {
    static func randomList(withLength length: Int) -> [Int] {
        var numbers: [Int] = []
        while Set(numbers).count < length {
            numbers.append(random(in: 0...length * 3))
        }
        return Array(Set(numbers))
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
