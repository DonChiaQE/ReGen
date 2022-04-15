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
