import SwiftUI

struct ShapeStruct {
    var num: Int
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    var diameter: Int
    var thickness: Int
    var color: Color
    var animate: Bool
    var polygonSides: Int
    var rotation: Int
    var offset = CGPoint(x: 0, y: 0)
    var scale: CGFloat = 1.0
    var lastScaleValue: CGFloat = 1.0
}

struct ShapeView {
    let id = UUID()
    var ShapeValue: Int
    var View: ShapeStruct
}

struct ContentView: View {
    @State var ShapeViews = [
        AnyView(RecursiveRect(num: 10, x: 0, y: 0, width: 5, height: 5, thickness: 1, color: .green, animate: true)),
        AnyView(RecursiveCircle(num: 0, x: 0, y: 0, diameter: 0, thickness: 0, color: .white, animate: true)),
        AnyView(RecursiveTriangle(num: 0, x: 0, y: 0, width: 0, height: 0, thickness: 0, color: .white, animate: true)),
        AnyView(RecursiveShape(num: 0, x: 0, y: 0, width: 0, height: 0, thickness: 0, color: .white, shape: AnyShape(Polygon(sides: 0)), animate: true))
    ]
    @State var SelectedShapeLayers:[ShapeView] = []
    @State var RandomParams = false
    @State var backgroundColor = Color.white
    @State var checkClear = false
    
    func disableGenerate() -> Bool {
        if SelectedShapeLayers.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    func showShapeName(number: Int) -> String {
        if number == 0 {
            return "Rectangle"
        } else if number == 1 {
            return "Circle"
        } else if number == 2 {
            return "Triangle"
        } else if number == 3 {
            return "Polygon"
        } else {
            return "It's Razzle Dazzle Time" // why are you seeing this
        }
    }
    
    enum AlertType: Identifiable {
        case first, second, third, fourth, fifth, sixth, seventh
        
        var id: Int {
            hashValue
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        SelectedShapeLayers.move(fromOffsets: source, toOffset: destination)
    }
    
    @State var alertType: AlertType?
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Layers")) {
                    ForEach(SelectedShapeLayers.indices, id: \.self) { index in
                        NavigationLink(destination: EditingView(ShapeView: $SelectedShapeLayers[index])) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack(spacing: 0) {
                                        Text("Type: ")
                                        Text("\(showShapeName(number: SelectedShapeLayers[index].ShapeValue))").bold()
                                    }
                                    HStack(spacing: 0) {
                                        Text("Layer: ")
                                        Text("\(index + 1) ").bold()
                                        if index+1 == 1 && SelectedShapeLayers.count > 1 {
                                            Text("(Top Layer)").bold()
                                        }
                                        if index+1 == SelectedShapeLayers.count && SelectedShapeLayers.count > 1 {
                                            Text("(Bottom Layer)").bold()
                                        }
                                    }
                                    HStack(spacing: 0) {
                                        Text("Outline Color: ")
                                        Rectangle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(SelectedShapeLayers[index].View.color)
                                            .cornerRadius(4)
                                    }
                                }.contextMenu(menuItems: {
                                    Button("Duplicate") {
                                        SelectedShapeLayers.append(SelectedShapeLayers[index])
                                    }
                                })
                                Spacer()
                            }
                            .font(.system(.body, design: .monospaced))
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(6)
                        }.onDrag {
                            return NSItemProvider()
                        }
                    }
                    .onDelete { indexSet in
                        SelectedShapeLayers.remove(atOffsets: indexSet)
                    }
                    .onMove(perform: move)
                }
                
                Section(header: Text("Shapes")) {
                    Button("Rectangles") {
                        if RandomParams {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 0, View: ShapeStruct(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), width: Int.random(in: 1..<50), height: Int.random(in: 1..<50), diameter: Int.random(in: 1..<50), thickness: Int.random(in: 1..<10), color: Color.random, animate: true, polygonSides: Int.random(in: 1..<10), rotation: Int.random(in: 0..<360))))
                        } else {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 0)))
                        }
                    }
                    
                    Button("Circles") {
                        if RandomParams {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), width: Int.random(in: 1..<50), height: Int.random(in: 1..<50), diameter: Int.random(in: 1..<50), thickness: Int.random(in: 1..<10), color: Color.random, animate: true, polygonSides: Int.random(in: 1..<10), rotation: Int.random(in: 0..<360))))
                        } else {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 10, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 0)))
                        }
                    }
                    
                    Button("Triangles") {
                        if RandomParams {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 2, View: ShapeStruct(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), width: Int.random(in: 1..<50), height: Int.random(in: 1..<50), diameter: Int.random(in: 1..<50), thickness: Int.random(in: 1..<10), color: Color.random, animate: true, polygonSides: Int.random(in: 1..<10), rotation: Int.random(in: 0..<360))))
                        } else {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 2, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 10, thickness: 2, color: .blue, animate: true, polygonSides: 6, rotation: 0)))
                        }
                    }
                    
                    Button("Polygons") {
                        if RandomParams {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 3, View: ShapeStruct(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), width: Int.random(in: 1..<50), height: Int.random(in: 1..<50), diameter: Int.random(in: 1..<50), thickness: Int.random(in: 1..<10), color: Color.random, animate: true, polygonSides: Int.random(in: 1..<10), rotation: Int.random(in: 0..<360))))
                        } else {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 3, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 10, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 0)))
                        }
                    }
                }
                
                Section(header: Text("Demo Art")) {
                    Button("Supremus I (Malevich Homage)") {
                        if SelectedShapeLayers.count > 0 {
                            alertType = .fourth
                        } else {
                            SelectedShapeLayers = [
                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 5, height: 7, diameter: 0, thickness: 2, color: .yellow , animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -343.0, y: 42.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 27, height: 10, diameter: 0, thickness: 2, color: .yellow , animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -118.0, y: -185.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 11, height: 8, diameter: 0, thickness: 2, color: .yellow , animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -271.0, y: -36.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 40, height: 3, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 171, offset: CGPoint(x: -93.0, y: -214.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 12, height: 1, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 171, offset: CGPoint(x: -202.0, y: -247.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 13, height: 5, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 134, offset: CGPoint(x: -62.0, y: -111.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 8, height: 7, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 131, offset: CGPoint(x: 14.5, y: -71.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 6, height: 6, diameter: 0, thickness: 1, color: .black, animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: 35.0, y: 353.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 29, height: 25, diameter: 0, thickness: 2, color: .black, animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -162.5, y: 125.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 17, height: 10, diameter: 0, thickness: 2, color: .black, animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -34.5, y: 272.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 3, height: 9, diameter: 0, thickness: 1, color: .blue, animate: true, polygonSides: 6, rotation: 131, offset: CGPoint(x: 83.5, y: 184.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 4, height: 14, diameter: 0, thickness: 1, color: .blue, animate: true, polygonSides: 6, rotation: 131, offset: CGPoint(x: -309.5, y: 256.5), scale: 1.0, lastScaleValue: 1.0))
                                ]
                            backgroundColor = Color(red: 0.96, green: 0.96, blue: 0.94)
                        }
                    }
                    
                    Button("Supremus II") {
                        if SelectedShapeLayers.count > 0 {
                            alertType = .fifth
                        } else {
                            SelectedShapeLayers = [
                             ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 8, height: 18, diameter: 0, thickness: 4, color: .black, animate: true, polygonSides: 6, rotation: 145, offset: CGPoint(x: -211.0, y: 79.5), scale: 1.0, lastScaleValue: 1.0)),

                             ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 50, height: 6, diameter: 0, thickness: 3, color: .black, animate: true, polygonSides: 6, rotation: 147, offset: CGPoint(x: -168.5, y: -237.0), scale: 1.0, lastScaleValue: 1.0)),

                             ShapeView(ShapeValue: 0, View: ShapeStruct(num: 8, x: 0, y: 0, width: 36, height: 5, diameter: 0, thickness: 2, color: .blue , animate: true, polygonSides: 6, rotation: 148, offset: CGPoint(x: -191.5, y: -112.5), scale: 1.0, lastScaleValue: 1.0)),

                             ShapeView(ShapeValue: 2, View: ShapeStruct(num: 10, x: 1, y: 0, width: 15, height: 10, diameter: 10, thickness: 3, color: .red, animate: true, polygonSides: 6, rotation: 187, offset: CGPoint(x: 163.5, y: -177.0), scale: 1.0, lastScaleValue: 1.0)),

                             ShapeView(ShapeValue: 2, View: ShapeStruct(num: 10, x: 1, y: 0, width: 15, height: 10, diameter: 10, thickness: 3, color: .red, animate: true, polygonSides: 6, rotation: 100, offset: CGPoint(x: -343.0, y: -239.0), scale: 1.0, lastScaleValue: 1.0)),

                             ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 31, height: 10, diameter: 0, thickness: 2, color: .blue , animate: true, polygonSides: 6, rotation: 145, offset: CGPoint(x: -175.5, y: -378.5), scale: 1.0, lastScaleValue: 1.0)),

                             ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 21, height: 27, diameter: 0, thickness: 2, color: .blue, animate: true, polygonSides: 6, rotation: 55, offset: CGPoint(x: 12.5, y: -50.5), scale: 1.0, lastScaleValue: 1.0)),

                             ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 7, height: 22, diameter: 0, thickness: 2, color: .black , animate: true, polygonSides: 6, rotation: 58, offset: CGPoint(x: -45.0, y: 193.5), scale: 1.0, lastScaleValue: 1.0)),

                             ShapeView(ShapeValue: 0, View: ShapeStruct(num: 20, x: 0, y: 0, width: 20, height: 20, diameter: 0, thickness: 9, color: .black, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: 183.5, y: 179.0), scale: 1.0, lastScaleValue: 1.0))
                             ]

                            backgroundColor = Color(red: 1, green: 1, blue: 0.95)
                        }
                    }
                    
                    Button("Supremus III") {
                        if SelectedShapeLayers.count > 0 {
                            alertType = .sixth
                        } else {
                            SelectedShapeLayers = [
                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 22, offset: CGPoint(x: 361.0, y: 140.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 7, height: 25, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 27, offset: CGPoint(x: 252.0, y: 93.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 6, height: 38, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 27, offset: CGPoint(x: 153.0, y: 36.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 6, height: 50, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 32, offset: CGPoint(x: 76.5, y: -27.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 15, x: 0, y: 0, width: 13, height: 50, diameter: 0, thickness: 2, color: .black , animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -306.5, y: -17.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 15, x: 0, y: 0, width: 50, height: 3, diameter: 0, thickness: 2, color: .black, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: 69.5, y: 31.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 8, x: 4, y: 0, width: 0, height: 0, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 9, offset: CGPoint(x: -123.5, y: -35.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 6, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -258.0, y: -424.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 6, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -137.5, y: -247.5), scale: 1.0, lastScaleValue: 1.0))
                            ]
                            
                            backgroundColor = Color(red: 0.96, green: 0.96, blue: 0.94)
                        }
                    }
                    
                    Button("Supremus IV") {
                        if SelectedShapeLayers.count > 0 {
                            alertType = .second
                        } else {
                            SelectedShapeLayers = [
                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 20, height: 20, diameter: 0, thickness: 5, color: .black, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -12.5, y: 264.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 43, height: 5, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -24.5, y: 121.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 3, View: ShapeStruct(num: 10, x: 0, y: 0, width: 13, height: 10, diameter: 10, thickness: 4, color: .red, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -25.5, y: 31.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 3, View: ShapeStruct(num: 10, x: 0, y: 0, width: 13, height: 10, diameter: 10, thickness: 4, color: .red, animate: true, polygonSides: 7, rotation: 0, offset: CGPoint(x: 115.5, y: 32.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 3, View: ShapeStruct(num: 10, x: 0, y: 0, width: 13, height: 10, diameter: 10, thickness: 4, color: .red, animate: true, polygonSides: 5, rotation: 0, offset: CGPoint(x: -179.0, y: 37.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 27, height: 2, diameter: 0, thickness: 10, color: .black, animate: true, polygonSides: 6, rotation: 162, offset: CGPoint(x: -231.5, y: -28.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 5, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 7, color: .blue, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -337.5, y: -35.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 5, x: 0, y: 2, width: 0, height: 0, diameter: 10, thickness: 7, color: .blue, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -385.0, y: 103.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 5, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 7, color: .blue, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -203.0, y: -79.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 2, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 20, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -374.0, y: 268.5), scale: 1.0, lastScaleValue: 1.0))]
                            backgroundColor = Color(red: 1, green: 1, blue: 0.95)
                        }
                    }
                    
                    Button("Supremus V") {
                        if SelectedShapeLayers.count > 0 {
                            alertType = .seventh
                        } else {
                            SelectedShapeLayers = [
                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: 117.5, y: -348.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .blue, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -5.0, y: -314.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -117.5, y: -290.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 1, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -348.5, y: -192.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .purple , animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -239.0, y: -261.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 16, x: 0, y: 0, width: 38, height: 40, diameter: 0, thickness: 10, color: .black , animate: true, polygonSides: 6, rotation: 167, offset: CGPoint(x: 103.0, y: 54.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: 231.5, y: -371.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 3, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color:  .green, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -324.0, y: -46.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 4, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .blue , animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -258.0, y: 192.5), scale: 1.0, lastScaleValue: 1.0))
                                ]
                            backgroundColor = Color(red: 1, green: 1, blue: 0.95)
                        }
                    }
                    
                    Button("Molecule") {
                        if SelectedShapeLayers.count > 0 {
                            alertType = .first
                        } else {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 20, x: 1, y: 0, width: 0, height: 0, diameter: 20, thickness: 2, color: .green, animate: true, polygonSides: 0, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 20, x: -1, y: 0, width: 0, height: 0, diameter: 20, thickness: 2, color: .green, animate: true, polygonSides: 0, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 20, x: 0, y: 1, width: 0, height: 0, diameter: 20, thickness: 2, color: .green, animate: true, polygonSides: 0, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 20, x: 0, y: -1, width: 0, height: 0, diameter: 20, thickness: 2, color: .green, animate: true, polygonSides: 0, rotation: 0)))
                            backgroundColor = Color.black
                        }
                    }
                    
//                    Button("Flower") {
//                        if SelectedShapeLayers.count > 0 {
//                            alertType = .second
//                        } else {
//                            SelectedShapeLayers.append(ShapeView(ShapeValue: 0, View: ShapeStruct(num: 20, x: 2, y: 0, width: 20, height: 20, diameter: 0, thickness: 1, color: .yellow, animate: true, polygonSides: 0, rotation: 0)))
//                            SelectedShapeLayers.append(ShapeView(ShapeValue: 0, View: ShapeStruct(num: 20, x: -2, y: 0, width: 20, height: 20, diameter: 0, thickness: 1, color: .yellow, animate: true, polygonSides: 0, rotation: 0)))
//                            SelectedShapeLayers.append(ShapeView(ShapeValue: 0, View: ShapeStruct(num: 20, x: 0, y: 2, width: 20, height: 20, diameter: 0, thickness: 1, color: .yellow, animate: true, polygonSides: 0, rotation: 0)))
//                            SelectedShapeLayers.append(ShapeView(ShapeValue: 0, View: ShapeStruct(num: 20, x: 0, y: -2, width: 20, height: 20, diameter: 0, thickness: 1, color: .yellow, animate: true, polygonSides: 0, rotation: 0)))
//                            backgroundColor = Color.black
//                        }
//                    }
                }
                
                Section(header: Text("Background")) {
                    ColorPicker("Canvas Color Selection", selection: $backgroundColor)
                }
            }.navigationTitle(Text("Layer Creation"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: GenerateArtView(SelectedShapeLayers: $SelectedShapeLayers, BackgroundColor: $backgroundColor)) {
                            Text("Generate")
                        }.disabled(disableGenerate())
                    }
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Toggle(isOn: $RandomParams) {
                                Text("Random Parameters")
                            }
                            Spacer()
                            Button("Reset") {
                                SelectedShapeLayers = []
                                backgroundColor = Color.white
                            }
                        }
                    }
                }
                .listStyle(.sidebar)
                .alert(isPresented: $checkClear, content: {
                    return Alert(title: Text("Existing Layers"), message: Text("Are you sure you want to clear your layers?"), primaryButton: .default(Text("Yes"), action: {
                        SelectedShapeLayers = []
                    }), secondaryButton: .destructive(Text("No")))
                })
                .alert(item: $alertType) { type in
                    switch type {
                    case .first:
                        return Alert(title: Text("Existing Layers"), message: Text("Are you sure you want to clear your layers?"), primaryButton: .default(Text("Yes"), action: {
                            SelectedShapeLayers = []
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 20, x: 1, y: 0, width: 0, height: 0, diameter: 20, thickness: 2, color: .green, animate: true, polygonSides: 0, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 20, x: -1, y: 0, width: 0, height: 0, diameter: 20, thickness: 2, color: .green, animate: true, polygonSides: 0, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 20, x: 0, y: 1, width: 0, height: 0, diameter: 20, thickness: 2, color: .green, animate: true, polygonSides: 0, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 20, x: 0, y: -1, width: 0, height: 0, diameter: 20, thickness: 2, color: .green, animate: true, polygonSides: 0, rotation: 0)))
                            backgroundColor = Color.black
                        }), secondaryButton: .destructive(Text("No")))
                    case .second:
                        return Alert(title: Text("Existing Layers"), message: Text("Are you sure you want to clear your layers?"), primaryButton: .default(Text("Yes"), action: {
                            SelectedShapeLayers = []
                            SelectedShapeLayers = [
                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 20, height: 20, diameter: 0, thickness: 5, color: .black, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -12.5, y: 264.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 43, height: 5, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -24.5, y: 121.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 3, View: ShapeStruct(num: 10, x: 0, y: 0, width: 13, height: 10, diameter: 10, thickness: 4, color: .red, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -25.5, y: 31.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 3, View: ShapeStruct(num: 10, x: 0, y: 0, width: 13, height: 10, diameter: 10, thickness: 4, color: .red, animate: true, polygonSides: 7, rotation: 0, offset: CGPoint(x: 115.5, y: 32.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 3, View: ShapeStruct(num: 10, x: 0, y: 0, width: 13, height: 10, diameter: 10, thickness: 4, color: .red, animate: true, polygonSides: 5, rotation: 0, offset: CGPoint(x: -179.0, y: 37.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 27, height: 2, diameter: 0, thickness: 10, color: .black, animate: true, polygonSides: 6, rotation: 162, offset: CGPoint(x: -231.5, y: -28.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 5, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 7, color: .blue, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -337.5, y: -35.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 5, x: 0, y: 2, width: 0, height: 0, diameter: 10, thickness: 7, color: .blue, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -385.0, y: 103.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 5, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 7, color: .blue, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -203.0, y: -79.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 2, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 20, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -374.0, y: 268.5), scale: 1.0, lastScaleValue: 1.0))]
                            
                            backgroundColor = Color(red: 1, green: 1, blue: 0.95)
                        }), secondaryButton: .destructive(Text("No")))
                    case .third:
                        return Alert(title: Text("Existing Layers"), message: Text("Are you sure you want to clear your layers?"), primaryButton: .default(Text("Yes"), action: {
                            SelectedShapeLayers = []
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 3, View: ShapeStruct(num: 5, x: 0, y: 0, width: 25, height: 25, diameter: 0, thickness: 2, color: .black, animate: true, polygonSides: 6, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 3, View: ShapeStruct(num: 10, x: 0, y: 0, width: 25, height: 25, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 3, View: ShapeStruct(num: 15, x: 0, y: 0, width: 25, height: 25, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 3, View: ShapeStruct(num: 20, x: 0, y: 0, width: 25, height: 25, diameter: 0, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 0)))
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 3, View: ShapeStruct(num: 25, x: 0, y: 0, width: 25, height: 25, diameter: 0, thickness: 2, color: .blue, animate: true, polygonSides: 6, rotation: 0)))
                            backgroundColor = Color.purple
                        }), secondaryButton: .destructive(Text("No")))
                    case .fourth:
                        return Alert(title: Text("Existing Layers"), message: Text("Are you sure you want to clear your layers?"), primaryButton: .default(Text("Yes"), action: {
                                SelectedShapeLayers = []
                                SelectedShapeLayers = [
                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 5, height: 7, diameter: 0, thickness: 2, color: .yellow , animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -343.0, y: 42.0), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 27, height: 10, diameter: 0, thickness: 2, color: .yellow , animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -118.0, y: -185.5), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 11, height: 8, diameter: 0, thickness: 2, color: .yellow , animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -271.0, y: -36.0), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 40, height: 3, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 171, offset: CGPoint(x: -93.0, y: -214.5), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 12, height: 1, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 171, offset: CGPoint(x: -202.0, y: -247.5), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 13, height: 5, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 134, offset: CGPoint(x: -62.0, y: -111.0), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 8, height: 7, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 131, offset: CGPoint(x: 14.5, y: -71.0), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 6, height: 6, diameter: 0, thickness: 1, color: .black, animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: 35.0, y: 353.0), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 29, height: 25, diameter: 0, thickness: 2, color: .black, animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -162.5, y: 125.5), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 17, height: 10, diameter: 0, thickness: 2, color: .black, animate: true, polygonSides: 6, rotation: 138, offset: CGPoint(x: -34.5, y: 272.5), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 3, height: 9, diameter: 0, thickness: 1, color: .blue, animate: true, polygonSides: 6, rotation: 131, offset: CGPoint(x: 83.5, y: 184.5), scale: 1.0, lastScaleValue: 1.0)),

                                    ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 4, height: 14, diameter: 0, thickness: 1, color: .blue, animate: true, polygonSides: 6, rotation: 131, offset: CGPoint(x: -309.5, y: 256.5), scale: 1.0, lastScaleValue: 1.0))
                                    ]
                            backgroundColor = Color(red: 0.96, green: 0.96, blue: 0.94)

                        }), secondaryButton: .destructive(Text("No")))
                    case .fifth:
                        return Alert(title: Text("Existing Layers"), message: Text("Are you sure you want to clear your layers?"), primaryButton: .default(Text("Yes"), action: {
                            SelectedShapeLayers = []
                           SelectedShapeLayers = [
                            ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 8, height: 18, diameter: 0, thickness: 4, color: .black, animate: true, polygonSides: 6, rotation: 145, offset: CGPoint(x: -211.0, y: 79.5), scale: 1.0, lastScaleValue: 1.0)),

                            ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 50, height: 6, diameter: 0, thickness: 3, color: .black, animate: true, polygonSides: 6, rotation: 147, offset: CGPoint(x: -168.5, y: -237.0), scale: 1.0, lastScaleValue: 1.0)),

                            ShapeView(ShapeValue: 0, View: ShapeStruct(num: 8, x: 0, y: 0, width: 36, height: 5, diameter: 0, thickness: 2, color: .blue , animate: true, polygonSides: 6, rotation: 148, offset: CGPoint(x: -191.5, y: -112.5), scale: 1.0, lastScaleValue: 1.0)),

                            ShapeView(ShapeValue: 2, View: ShapeStruct(num: 10, x: 1, y: 0, width: 15, height: 10, diameter: 10, thickness: 3, color: .red, animate: true, polygonSides: 6, rotation: 187, offset: CGPoint(x: 163.5, y: -177.0), scale: 1.0, lastScaleValue: 1.0)),

                            ShapeView(ShapeValue: 2, View: ShapeStruct(num: 10, x: 1, y: 0, width: 15, height: 10, diameter: 10, thickness: 3, color: .red, animate: true, polygonSides: 6, rotation: 100, offset: CGPoint(x: -343.0, y: -239.0), scale: 1.0, lastScaleValue: 1.0)),

                            ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 31, height: 10, diameter: 0, thickness: 2, color: .blue , animate: true, polygonSides: 6, rotation: 145, offset: CGPoint(x: -175.5, y: -378.5), scale: 1.0, lastScaleValue: 1.0)),

                            ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 21, height: 27, diameter: 0, thickness: 2, color: .blue, animate: true, polygonSides: 6, rotation: 55, offset: CGPoint(x: 12.5, y: -50.5), scale: 1.0, lastScaleValue: 1.0)),

                            ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 7, height: 22, diameter: 0, thickness: 2, color: .black , animate: true, polygonSides: 6, rotation: 58, offset: CGPoint(x: -45.0, y: 193.5), scale: 1.0, lastScaleValue: 1.0)),

                            ShapeView(ShapeValue: 0, View: ShapeStruct(num: 20, x: 0, y: 0, width: 20, height: 20, diameter: 0, thickness: 9, color: .black, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: 183.5, y: 179.0), scale: 1.0, lastScaleValue: 1.0))
                            ]

                            backgroundColor = Color(red: 1, green: 1, blue: 0.95)
                            
                        }), secondaryButton: .destructive(Text("No")))
                        
                    case .sixth:
                        return Alert(title: Text("Existing Layers"), message: Text("Are you sure you want to clear your layers?"), primaryButton: .default(Text("Yes"), action: {
                            SelectedShapeLayers = []
                            SelectedShapeLayers = [
                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 22, offset: CGPoint(x: 361.0, y: 140.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 7, height: 25, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 27, offset: CGPoint(x: 252.0, y: 93.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 6, height: 38, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 27, offset: CGPoint(x: 153.0, y: 36.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 6, height: 50, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 32, offset: CGPoint(x: 76.5, y: -27.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 15, x: 0, y: 0, width: 13, height: 50, diameter: 0, thickness: 2, color: .black , animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -306.5, y: -17.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 15, x: 0, y: 0, width: 50, height: 3, diameter: 0, thickness: 2, color: .black, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: 69.5, y: 31.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 8, x: 4, y: 0, width: 0, height: 0, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 9, offset: CGPoint(x: -123.5, y: -35.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 6, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -258.0, y: -424.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 1, View: ShapeStruct(num: 6, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 0, offset: CGPoint(x: -137.5, y: -247.5), scale: 1.0, lastScaleValue: 1.0))
                            ]
                            
                            backgroundColor = Color(red: 1, green: 1, blue: 0.95)
                        }), secondaryButton: .destructive(Text("No")))
                        
                    case .seventh:
                        return Alert(title: Text("Existing Layers"), message: Text("Are you sure you want to clear your layers?"), primaryButton: .default(Text("Yes"), action: {
                            SelectedShapeLayers = []
                            SelectedShapeLayers = [
                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .green, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: 117.5, y: -348.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .blue, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -5.0, y: -314.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .yellow, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -117.5, y: -290.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 1, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -348.5, y: -192.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .purple , animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -239.0, y: -261.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 16, x: 0, y: 0, width: 38, height: 40, diameter: 0, thickness: 10, color: .black , animate: true, polygonSides: 6, rotation: 167, offset: CGPoint(x: 103.0, y: 54.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: 231.5, y: -371.0), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 3, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color:  .green, animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -324.0, y: -46.5), scale: 1.0, lastScaleValue: 1.0)),

                                ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 4, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .blue , animate: true, polygonSides: 6, rotation: 78, offset: CGPoint(x: -258.0, y: 192.5), scale: 1.0, lastScaleValue: 1.0))
                                ]
                            backgroundColor = Color(red: 1, green: 1, blue: 0.95)
                        }), secondaryButton: .destructive(Text("No")))
                    }
                }
            
            
        }
    }
}

struct ArtCanvas: View {
    @Binding var SelectedShapeLayers: [ShapeView]
    @Binding var BackgroundColor: Color
    @State var showDelete: Bool = false
    @State var currentIndex: Int = 10
    @State var showEdit: Bool = false
    @State var showMenu: Bool = false
    func showShapeName(number: Int) -> String {
        if number == 0 {
            return "Rectangles"
        } else if number == 1 {
            return "Circles"
        } else if number == 2 {
            return "Triangles"
        } else if number == 3 {
            return "Polygons"
        } else {
            return "It's Razzle Dazzle Time" // why are you seeing this
        }
    }
    var body: some View {
        ZStack {
            BackgroundColor.ignoresSafeArea()
            ForEach(SelectedShapeLayers.indices.reversed(), id: \.self) { index in
                if  SelectedShapeLayers[index].ShapeValue == 0 {
                    
                    RecursiveRect(num: SelectedShapeLayers[index].View.num, x:  SelectedShapeLayers[index].View.x, y:  SelectedShapeLayers[index].View.y, width:  SelectedShapeLayers[index].View.width, height:  SelectedShapeLayers[index].View.height, thickness:  SelectedShapeLayers[index].View.thickness, color:  SelectedShapeLayers[index].View.color, animate:  SelectedShapeLayers[index].View.animate)
                        .rotationEffect(.degrees(Double(SelectedShapeLayers[index].View.rotation)))
                        .highPriorityGesture(DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                SelectedShapeLayers[index].View.offset.x += value.location.x - value.startLocation.x
                                SelectedShapeLayers[index].View.offset.y += value.location.y - value.startLocation.y
                            })
                        .offset(x:  SelectedShapeLayers[index].View.offset.x, y:  SelectedShapeLayers[index].View.offset.y)
                        .scaleEffect(
                            SelectedShapeLayers[index].View.scale
                        )
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    currentIndex = index
                                    showMenu.toggle()
                                }
                        )
                    
                    
                } else if SelectedShapeLayers[index].ShapeValue == 1 {
                    RecursiveCircle(num: SelectedShapeLayers[index].View.num, x: SelectedShapeLayers[index].View.x, y: SelectedShapeLayers[index].View.y, diameter: SelectedShapeLayers[index].View.diameter, thickness: SelectedShapeLayers[index].View.thickness, color: SelectedShapeLayers[index].View.color, animate: SelectedShapeLayers[index].View.animate)
                        .rotationEffect(.degrees(Double(SelectedShapeLayers[index].View.rotation)))
                        .highPriorityGesture(DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                SelectedShapeLayers[index].View.offset.x += value.location.x - value.startLocation.x
                                SelectedShapeLayers[index].View.offset.y += value.location.y - value.startLocation.y
                            })
                        .offset(x:  SelectedShapeLayers[index].View.offset.x, y:  SelectedShapeLayers[index].View.offset.y)
                        .scaleEffect(
                            SelectedShapeLayers[index].View.scale
                        )
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    currentIndex = index
                                    showMenu.toggle()
                                }
                        )
                    
                    
                } else if SelectedShapeLayers[index].ShapeValue == 2 {
                    RecursiveTriangle(num: SelectedShapeLayers[index].View.num, x: SelectedShapeLayers[index].View.x, y: SelectedShapeLayers[index].View.y, width: SelectedShapeLayers[index].View.width, height: SelectedShapeLayers[index].View.height, thickness: SelectedShapeLayers[index].View.thickness, color: SelectedShapeLayers[index].View.color, animate: SelectedShapeLayers[index].View.animate)
                        .rotationEffect(.degrees(Double(SelectedShapeLayers[index].View.rotation)))
                        .highPriorityGesture(DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                SelectedShapeLayers[index].View.offset.x += value.location.x - value.startLocation.x
                                SelectedShapeLayers[index].View.offset.y += value.location.y - value.startLocation.y
                            })
                        .offset(x:  SelectedShapeLayers[index].View.offset.x, y:  SelectedShapeLayers[index].View.offset.y)
                        .scaleEffect(
                            SelectedShapeLayers[index].View.scale
                        )
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    currentIndex = index
                                    showMenu.toggle()
                                }
                        )
                    
                } else if SelectedShapeLayers[index].ShapeValue == 3 {
                    RecursiveShape(num: SelectedShapeLayers[index].View.num, x: SelectedShapeLayers[index].View.x, y: SelectedShapeLayers[index].View.y, width: SelectedShapeLayers[index].View.width, height: SelectedShapeLayers[index].View.height, thickness: SelectedShapeLayers[index].View.thickness, color: SelectedShapeLayers[index].View.color, shape: AnyShape(Polygon(sides: SelectedShapeLayers[index].View.polygonSides)), animate: SelectedShapeLayers[index].View.animate)
                        .rotationEffect(.degrees(Double(SelectedShapeLayers[index].View.rotation)))
                        .highPriorityGesture(DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                SelectedShapeLayers[index].View.offset.x += value.location.x - value.startLocation.x
                                SelectedShapeLayers[index].View.offset.y += value.location.y - value.startLocation.y
                            })
                        .offset(x:  SelectedShapeLayers[index].View.offset.x, y:  SelectedShapeLayers[index].View.offset.y)
                        .scaleEffect(
                            SelectedShapeLayers[index].View.scale
                        )
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    currentIndex = index
                                    showMenu.toggle()
                                }
                        )
                    
                }
            }
        }.alert(isPresented: $showDelete) {
            Alert(
                title: Text("Delete this layer?"),
                message: Text("Layer will be removed."),
                primaryButton: .destructive(Text("Delete")) {
                    SelectedShapeLayers.remove(at: currentIndex)
                },
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $showEdit) {
            ScrollView {
            VStack(alignment: .leading) {
                Text("Layer \(currentIndex + 1) (\(showShapeName(number: SelectedShapeLayers[currentIndex].ShapeValue)))")
                    .font(.system(.title))
                    .bold()
                    .padding(.bottom)
                Group {
                    Text("Number of \(showShapeName(number: SelectedShapeLayers[currentIndex].ShapeValue))")
                    IntSlider(value: $SelectedShapeLayers[currentIndex].View.num, shapeName: "\(showShapeName(number: SelectedShapeLayers[currentIndex].ShapeValue))", lowerBound: 1, upperBound: 30)
                    Text("X Displacement")
                    IntSlider(value: $SelectedShapeLayers[currentIndex].View.x, shapeName: "", lowerBound: -10, upperBound: 10)
                    Text("Y Displacement")
                    IntSlider(value: $SelectedShapeLayers[currentIndex].View.y, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                if SelectedShapeLayers[currentIndex].ShapeValue == 0 || SelectedShapeLayers[currentIndex].ShapeValue == 2 {
                    Group {
                        Text("Width")
                        IntSlider(value: $SelectedShapeLayers[currentIndex].View.width, shapeName: "", lowerBound: 1, upperBound: 50)
                        Text("Height")
                        IntSlider(value: $SelectedShapeLayers[currentIndex].View.height, shapeName: "", lowerBound: 1, upperBound: 50)
                    }
                } else if SelectedShapeLayers[currentIndex].ShapeValue == 1 {
                    Group {
                        Text("Diameter")
                        IntSlider(value: $SelectedShapeLayers[currentIndex].View.diameter, shapeName: "", lowerBound: 1, upperBound: 50)
                    }
                } else {
                    Group {
                        Text("Width")
                        IntSlider(value: $SelectedShapeLayers[currentIndex].View.width, shapeName: "", lowerBound: 1, upperBound: 50)
                        Text("Polygon Sides")
                        IntSlider(value: $SelectedShapeLayers[currentIndex].View.polygonSides, shapeName: "Sides", lowerBound: 1, upperBound: 10)
                    }
                }
                Group {
                    ColorPicker("Layer Outline Color", selection: $SelectedShapeLayers[currentIndex].View.color)
                    Text("Layer Rotational Value")
                    IntSlider(value: $SelectedShapeLayers[currentIndex].View.rotation, shapeName: "Degrees", lowerBound: 0, upperBound: 360)
                    Text("Layer Outline Thickness")
                    IntSlider(value: $SelectedShapeLayers[currentIndex].View.thickness, shapeName: "", lowerBound: 1, upperBound: 10)
                }
                Spacer()
            }
            .padding()
            }.clearModalBackground()
                .background(.white.opacity(0.5))
        }
        .alert("Layer \(currentIndex + 1) Actions", isPresented: $showMenu) {
            Button("Quick Edit", action: {
                showEdit.toggle()
            })
            Button("Delete Layer", role: .destructive, action: {
                SelectedShapeLayers.remove(at: currentIndex)
            })
            Button("Cancel", role: .cancel, action: {})
        }
    }
}

struct GenerateArtView: View {
    @Binding var SelectedShapeLayers: [ShapeView]
    @Binding var BackgroundColor: Color
    
    var body: some View {
        GeometryReader { geo in
            ArtCanvas(SelectedShapeLayers: $SelectedShapeLayers, BackgroundColor: $BackgroundColor)
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button{
//                                print(SelectedShapeLayers)
//
//                            } label: {
//                                Image(systemName: "square.and.arrow.up")
//                            }
//                        }
//                    }
        }.navigationBarTitle("", displayMode: .inline)
    }
}

struct EditingView: View {
    @Binding var ShapeView: ShapeView
    @State var showPreview: Bool = false
    var body: some View {
        if ShapeView.ShapeValue == 0 {
            Form {
                Section(header: Text("Number of Rectangles")) {
                    //                    TextField("5", value: $ShapeView.View.num, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.num, shapeName: "Rectangles", lowerBound: 1, upperBound: 30)
                }
                Section(header: Text("X Displacement")) {
                    IntSlider(value: $ShapeView.View.x, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Y Displacement")) {
                    //                    TextField("0", value: $ShapeView.View.y, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.y, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Rectangle Width")) {
                    //                    TextField("10", value: $ShapeView.View.width, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.width, shapeName: "", lowerBound: 1, upperBound: 50)
                }
                Section(header: Text("Rectangle Height")) {
                    //                    TextField("10", value: $ShapeView.View.height, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.height, shapeName: "", lowerBound: 1, upperBound: 50)
                }
                Section(header: Text("Rectangle Outline Thickness")) {
                    //                    TextField("2", value: $ShapeView.View.thickness, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.thickness, shapeName: "", lowerBound: 1, upperBound: 10)
                }
                Section(header: Text("Rectangle Rotation")) {
                    //                    TextField("2", value: $ShapeView.View.thickness, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.rotation, shapeName: "Degrees", lowerBound: 0, upperBound: 360)
                }
                Section(header: Text("Rectangle Outline Color")) {
                    ColorPicker("Rectangle Outline Color", selection: $ShapeView.View.color)
                }
                Section(header: Text("Animate Rectangles")) {
                    Toggle(isOn: $ShapeView.View.animate) {
                        Text("Toggle to animate Rectangles when appearing")
                    }
                }
                Button("Show Preview") {
                    showPreview.toggle()
                }
            }.navigationTitle(Text("Edit Rectangle Layer"))
                .sheet(isPresented: $showPreview) {
                    RecursiveRect(num: ShapeView.View.num, x: ShapeView.View.x, y: ShapeView.View.y, width: ShapeView.View.width, height: ShapeView.View.height, thickness: ShapeView.View.thickness, color: ShapeView.View.color, animate: ShapeView.View.animate)
                }
        } else if ShapeView.ShapeValue == 1 {
            Form {
                Section(header: Text("Number of Circles")) {
                    //                    TextField("5", value: $ShapeView.View.num, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.num, shapeName: "Circles", lowerBound: 1, upperBound: 30)
                }
                Section(header: Text("X Displacement")) {
                    //                    TextField("0", value: $ShapeView.View.x, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.x, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Y Displacement")) {
                    //                    TextField("0", value: $ShapeView.View.y, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.y, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Circle Diameter")) {
                    //                    TextField("10", value: $ShapeView.View.diameter, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.diameter, shapeName: "", lowerBound: 1, upperBound: 50)
                }
                Section(header: Text("Circle Outline Thickness")) {
                    //                    TextField("2", value: $ShapeView.View.thickness, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.thickness, shapeName: "", lowerBound: 1, upperBound: 10)
                }
                Section(header: Text("Circle Rotation")) {
                    //                    TextField("2", value: $ShapeView.View.thickness, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.rotation, shapeName: "Degrees", lowerBound: 0, upperBound: 360)
                }
                Section(header: Text("Circle Outline Color")) {
                    ColorPicker("Circle Outline Color", selection: $ShapeView.View.color)
                }
                Section(header: Text("Animate Circles")) {
                    Toggle(isOn: $ShapeView.View.animate) {
                        Text("Toggle to animate Circles when appearing")
                    }
                }
                Button("Show Preview") {
                    showPreview.toggle()
                }
            }.navigationTitle(Text("Edit Circle Layer"))
                .sheet(isPresented: $showPreview) {
                    RecursiveCircle(num: ShapeView.View.num, x: ShapeView.View.x, y: ShapeView.View.y, diameter: ShapeView.View.diameter, thickness: ShapeView.View.thickness, color: ShapeView.View.color, animate: ShapeView.View.animate)
                }
        } else if ShapeView.ShapeValue == 2 {
            Form {
                Section(header: Text("Number of Triangles")) {
                    //                    TextField("5", value: $ShapeView.View.num, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.num, shapeName: "Triangles", lowerBound: 1, upperBound: 30)
                }
                Section(header: Text("X Displacement")) {
                    //                    TextField("0", value: $ShapeView.View.x, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.x, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Y Displacement")) {
                    //                    TextField("0", value: $ShapeView.View.y, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.y, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Triangle Width")) {
                    //                    TextField("10", value: $ShapeView.View.width, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.width, shapeName: "", lowerBound: 1, upperBound: 50)
                }
                Section(header: Text("Triangle Height")) {
                    //                    TextField("10", value: $ShapeView.View.height, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.height, shapeName: "", lowerBound: 1, upperBound: 50)
                }
                Section(header: Text("Triangle Outline Thickness")) {
                    //                    TextField("2", value: $ShapeView.View.thickness, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.thickness, shapeName: "", lowerBound: 1, upperBound: 10)
                }
                Section(header: Text("Triangle Rotation")) {
                    //                    TextField("2", value: $ShapeView.View.thickness, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.rotation, shapeName: "Degrees", lowerBound: 0, upperBound: 360)
                }
                Section(header: Text("Triangle Outline Color")) {
                    ColorPicker("Triangle Outline Color", selection: $ShapeView.View.color)
                }
                Section(header: Text("Animate Triangles")) {
                    Toggle(isOn: $ShapeView.View.animate) {
                        Text("Toggle to animate Triangles when appearing")
                    }
                }
                Button("Show Preview") {
                    showPreview.toggle()
                }
            }.navigationTitle(Text("Edit Triangle Layer"))
                .sheet(isPresented: $showPreview) {
                    RecursiveTriangle(num: ShapeView.View.num, x: ShapeView.View.x, y: ShapeView.View.y, width: ShapeView.View.width, height: ShapeView.View.height, thickness: ShapeView.View.thickness, color: ShapeView.View.color, animate: ShapeView.View.animate)
                }
        } else if ShapeView.ShapeValue == 3 {
            Form {
                Section(header: Text("Number of Polygons")) {
                    IntSlider(value: $ShapeView.View.num, shapeName: "Polygons", lowerBound: 1, upperBound: 30)
                }
                Section(header: Text("X Displacement")) {
                    IntSlider(value: $ShapeView.View.x, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Y Displacement")) {
                    IntSlider(value: $ShapeView.View.y, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Polygon Width")) {
                    IntSlider(value: $ShapeView.View.width, shapeName: "", lowerBound: 1, upperBound: 50)
                }
                Group {
                    Section(header: Text("Polygon Outline Thickness")) {
                        IntSlider(value: $ShapeView.View.thickness, shapeName: "", lowerBound: 1, upperBound: 10)
                    }
                    Section(header: Text("Polygon Rotation")) {
                        IntSlider(value: $ShapeView.View.rotation, shapeName: "Degrees", lowerBound: 0, upperBound: 360)
                    }
                    Section(header: Text("Number of Sides")) {
                        IntSlider(value: $ShapeView.View.polygonSides, shapeName: "Sides", lowerBound: 1, upperBound: 10)
                    }
                    Section(header: Text("Polygon Outline Color")) {
                        ColorPicker("Polygon Outline Color", selection: $ShapeView.View.color)
                    }
                    Section(header: Text("Animate Polygons")) {
                        Toggle(isOn: $ShapeView.View.animate) {
                            Text("Toggle to animate Polygons when appearing")
                        }
                    }
                    Button("Show Preview") {
                        showPreview.toggle()
                    }
                }
            }.navigationTitle(Text("Edit Polygon Layer"))
                .sheet(isPresented: $showPreview) {
                    RecursiveShape(num: ShapeView.View.num, x: ShapeView.View.x, y: ShapeView.View.y, width: ShapeView.View.width, height: ShapeView.View.height, thickness: ShapeView.View.thickness, color: ShapeView.View.color, shape: AnyShape(Polygon(sides: ShapeView.View.polygonSides)), animate: ShapeView.View.animate)
                }
        }
    }
}
