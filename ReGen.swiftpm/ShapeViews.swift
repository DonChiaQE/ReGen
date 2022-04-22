//
//  ShapeViews.swift
//  Art of Recursion
//
//  Created by Don Chia on 14/4/22.
//

import SwiftUI

struct RecursiveShape: View {
    var num: Int
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    var thickness: Int
    var color: Color
    var shape: AnyShape
    var animate: Bool
    func RecursiveTreeShape(num: Int, x: Int, y: Int, width: Int, height: Int, thickness: Int, color: Color, shape: AnyShape, animate: Bool) -> some View {
        if num == 0 {
            return AnyView(
                shape
                    .stroke(color, lineWidth: CGFloat(thickness))
                    .foregroundColor(.clear)
                    .frame(width: CGFloat(num) * CGFloat(width), height: CGFloat(num) * CGFloat(height))
            )
        } else {
            return AnyView(
                ZStack {
                    shape
                        .stroke(color, lineWidth: CGFloat(thickness))
                        .onAppear(perform: {
                            self.value = 1.0
                        })
                        .opacity(self.value)
                        .animation(animate ? Animation.easeInOut(duration: 0.5).delay(Double(num)*0.1) : nil)
                        .foregroundColor(.clear)
                        .frame(width: CGFloat(num) * CGFloat(width), height: CGFloat(num) * CGFloat(height))
                    RecursiveTreeShape(num: num-1, x: x, y: y, width: width, height: height, thickness: thickness, color: color, shape: shape, animate: animate)
                        .offset(x: CGFloat(num*x), y: CGFloat(num*y))
                }
            )
        }
    }
    @State var value = 0.0
    var body: some View {
        RecursiveTreeShape(num: num, x: x, y: y, width: width, height: height, thickness: thickness, color: color, shape: shape, animate: animate)
    }
}

struct RecursiveRect: View {
    var num: Int
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    var thickness: Int
    var color: Color
    var animate: Bool
    
    func RecursiveTreeSquare(num: Int, x: Int, y: Int, width: Int, height: Int, thickness: Int, color: Color, animate: Bool) -> some View {
        if num == 0 {
            return AnyView(
                Rectangle()
                    .strokeBorder(color, lineWidth: CGFloat(thickness))
                    .foregroundColor(.clear)
                    .frame(width: CGFloat(num) * CGFloat(width), height: CGFloat(num) * CGFloat(height))
            )
        } else {
            return AnyView(
                ZStack {
                    Rectangle()
                        .strokeBorder(color, lineWidth: CGFloat(thickness))
                        .onAppear(perform: {
                            self.value = 1.0
                        })
                        .opacity(self.value)
                        .animation(animate ? Animation.easeInOut(duration: 0.5).delay(Double(num)*0.1) : nil)
                        .foregroundColor(.clear)
                        .frame(width: CGFloat(num) * CGFloat(width), height: CGFloat(num) * CGFloat(height))
                    RecursiveTreeSquare(num: num-1, x: x, y: y, width: width, height: height, thickness: thickness, color: color, animate: animate)
                        .offset(x: CGFloat(num*x), y: CGFloat(num*y))
                }
            )
        }
    }
    @State var value = 0.0
    var body: some View {
        RecursiveTreeSquare(num: num, x: x, y: y, width: width, height: height, thickness: thickness, color: color, animate: animate)
    }
}

struct RecursiveCircle: View {
    var num: Int
    var x: Int
    var y: Int
    var diameter: Int
    var thickness: Int
    var color: Color
    var animate: Bool
    
    func RecursiveTreeCircle(num: Int, x: Int, y: Int, diameter: Int, thickness: Int, color: Color, animate: Bool) -> some View {
        if num == 0 {
            return AnyView(
                Circle()
                    .strokeBorder(color, lineWidth: CGFloat(thickness))
                    .foregroundColor(.clear)
                    .frame(width: CGFloat(num) * CGFloat(diameter))
            )
        } else {
            return AnyView(
                ZStack {
                    Circle()
                        .strokeBorder(color, lineWidth: CGFloat(thickness))
                        .onAppear(perform: {
                            self.value = 1.0
                        })
                        .opacity(self.value)
                        .animation(animate ? Animation.easeInOut(duration: 0.5).delay(Double(num)*0.1) : nil)
                        .foregroundColor(.clear)
                        .frame(width: CGFloat(num) * CGFloat(diameter))
                    RecursiveTreeCircle(num: num-1, x: x, y: y, diameter: diameter, thickness: thickness, color: color, animate: animate)
                        .offset(x: CGFloat(num*x), y: CGFloat(num*y))
                }
            )
        }
    }
    @State var value = 0.0
    var body: some View {
        RecursiveTreeCircle(num: num, x: x, y: y, diameter: diameter, thickness: thickness, color: color, animate: animate)
    }
}

struct RecursiveTriangle: View {
    var num: Int
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    var thickness: Int
    var color: Color
    var animate: Bool
    
    func RecursiveTreeTriangle(num: Int, x: Int, y: Int, width: Int, height: Int, thickness: Int, color: Color, animate: Bool) -> some View {
        if num == 0 {
            return AnyView(
                Triangle()
                    .stroke(color, lineWidth: CGFloat(thickness))
                    .foregroundColor(.clear)
                    .frame(width: CGFloat(num) * CGFloat(width), height: CGFloat(num) * CGFloat(height))
            )
        } else {
            return AnyView(
                ZStack {
                    Triangle()
                        .stroke(color, lineWidth: CGFloat(thickness))
                        .onAppear(perform: {
                            self.value = 1.0
                        })
                        .opacity(self.value)
                        .animation(animate ? Animation.easeInOut(duration: 0.5).delay(Double(num)*0.1) : nil)
                        .foregroundColor(.clear)
                        .frame(width: CGFloat(num) * CGFloat(width), height: CGFloat(num) * CGFloat(height))
                    RecursiveTreeTriangle(num: num-1, x: x, y: y, width: width, height: height, thickness: thickness, color: color, animate: animate)
                        .offset(x: CGFloat(num*x), y: CGFloat(num*y))
                }
            )
        }
    }
    @State var value = 0.0
    var body: some View {
        RecursiveTreeTriangle(num: num, x: x, y: y, width: width, height: height, thickness: thickness, color: color, animate: animate)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct AnyShape: Shape {
    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }
    
    private let _path: (CGRect) -> Path
}

struct Polygon : Shape {
    var sides : Int
    
    func path(in rect : CGRect ) -> Path{
        // get the center point and the radius
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = rect.width / 2
        
        // get the angle in radian,
        // 2 pi divided by the number of sides
        let angle = Double.pi * 2 / Double(sides)
        var path = Path()
        var startPoint = CGPoint(x: 0, y: 0)
        
        for side in 0 ..< sides {
            
            let x = center.x + CGFloat(cos(Double(side) * angle)) * CGFloat (radius)
            let y = center.y + CGFloat(sin(Double(side) * angle)) * CGFloat(radius)
            
            let vertexPoint = CGPoint( x: x, y: y)
            
            if (side == 0) {
                startPoint = vertexPoint
                path.move(to: startPoint )
            }
            else {
                path.addLine(to: vertexPoint)
            }
            
            // move back to starting point
            // needed for stroke
            if ( side == (sides - 1) ){
                path.addLine(to: startPoint)
            }
        }
        
        return path
    }
}
