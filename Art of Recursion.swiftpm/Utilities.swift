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

extension Color {
    init?(_ hex: String) {
        var str = hex
        if str.hasPrefix("#") {
            str.removeFirst()
        }
        if str.count == 3 {
            str = String(repeating: str[str.startIndex], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 1)], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 2)], count: 2)
        } else if !str.count.isMultiple(of: 2) || str.count > 8 {
            return nil
        }
        let scanner = Scanner(string: str)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        if str.count == 2 {
            let gray = Double(Int(color) & 0xFF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
        } else if str.count == 4 {
            let gray = Double(Int(color >> 8) & 0x00FF) / 255
            let alpha = Double(Int(color) & 0x00FF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
        } else if str.count == 6 {
            let red = Double(Int(color >> 16) & 0x0000FF) / 255
            let green = Double(Int(color >> 8) & 0x0000FF) / 255
            let blue = Double(Int(color) & 0x0000FF) / 255
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
        } else if str.count == 8 {
            let red = Double(Int(color >> 24) & 0x000000FF) / 255
            let green = Double(Int(color >> 16) & 0x000000FF) / 255
            let blue = Double(Int(color >> 8) & 0x000000FF) / 255
            let alpha = Double(Int(color) & 0x000000FF) / 255
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
        } else {
            return nil
        }
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


struct IntSlider: View {
    @Binding var value: Int
    @State var shapeName: String
    @State var lowerBound: Double
    @State var upperBound: Double
    var intProxy: Binding<Double>{
        Binding<Double>(get: {
            return Double(value)
        }, set: {
            value = Int($0)
        })
    }
    func shapeNameChecker() -> String {
        var name = shapeName
        if name.isEmpty {
            return ""
        }
        if value > 1 {
            return name
        } else {
            name.removeLast()
            return name
        }
    }
    var body: some View {
        VStack{
            Text("\(value.description) \(shapeNameChecker())")
            Slider(value: intProxy , in: lowerBound...upperBound, step: 1.0)
        }
    }
}

private let defaultTimeout: TimeInterval = 4

struct SplashView<SplashContent: View>: ViewModifier {
  private let timeout: TimeInterval
  private let splashContent: () -> SplashContent

  @State private var isActive = true

  init(timeout: TimeInterval = defaultTimeout,
       @ViewBuilder splashContent: @escaping () -> SplashContent) {
    self.timeout = timeout
    self.splashContent = splashContent
  }

  func body(content: Content) -> some View {
    if isActive {
       splashContent()
        .onAppear {
           DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
             withAnimation {
               self.isActive = false
             }
           }
         }
    } else {
      content
    }
  }
}

extension View {
  func splashView<SplashContent: View>(
    timeout: TimeInterval = defaultTimeout,
    @ViewBuilder splashContent: @escaping () -> SplashContent
  ) -> some View {
    self.modifier(SplashView(timeout: timeout, splashContent: splashContent))
  }
}
