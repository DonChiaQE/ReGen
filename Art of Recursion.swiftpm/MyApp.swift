import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Re:Gen", systemImage: "pencil.and.outline")
                    }
                
                About()
                    .tabItem {
                        Label("About", systemImage: "questionmark.circle")
                    }
            }.splashView {
                ZStack {
                    ZStack {
                        Color.black
                            .overlay(Color.black.opacity(0.5))
                            .ignoresSafeArea(.all)
                        RecursiveCircle(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), diameter: Int.random(in: 1..<10), thickness: Int.random(in: 1..<2), color: Color.random, animate: true)
                        RecursiveCircle(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), diameter: Int.random(in: 1..<10), thickness: Int.random(in: 1..<10), color: Color.random, animate: true)
                        RecursiveCircle(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), diameter: Int.random(in: 1..<10), thickness: Int.random(in: 1..<10), color: Color.random, animate: true)
                        RecursiveCircle(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), diameter: Int.random(in: 1..<10), thickness: Int.random(in: 1..<10), color: Color.random, animate: true)
                        RecursiveCircle(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), diameter: Int.random(in: 1..<10), thickness: Int.random(in: 1..<10), color: Color.random, animate: true)
                        RecursiveCircle(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), diameter: Int.random(in: 1..<10), thickness: Int.random(in: 1..<10), color: Color.random, animate: true)
                        RecursiveCircle(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), diameter: Int.random(in: 1..<10), thickness: Int.random(in: 1..<10), color: Color.random, animate: true)
                        RecursiveCircle(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), diameter: Int.random(in: 1..<10), thickness: Int.random(in: 1..<10), color: Color.random, animate: true)
                        RecursiveCircle(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), diameter: Int.random(in: 1..<10), thickness: Int.random(in: 1..<10), color: Color.random, animate: true)
                    }.blur(radius: 1.2)
                    VStack {
                        Text("Re:Gen")
                            .font(.system(size: 80, weight: .medium, design: .default))
                            .foregroundColor(.white)
                        Text("There are no rules or recipes")
                            .font(.system(size: 24, weight: .ultraLight, design: .default))
                            .foregroundColor(.white)
                    }.background(.black.opacity(0.3))
                }
            }
        }
    }
}
