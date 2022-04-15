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
}

struct ShapeView {
    let id = UUID()
    var ShapeValue: Int
    var View: ShapeStruct
    var LayerNumber: Int
}

struct ContentView: View {
    @State var ShapeViews = [
        AnyView(RecursiveRect(num: 10, x: 0, y: 0, width: 5, height: 5, thickness: 1, color: .green, animate: true)),
        AnyView(RecursiveCircle(num: 0, x: 0, y: 0, diameter: 0, thickness: 0, color: .white, animate: true)),
        AnyView(RecursiveTriangle(num: 0, x: 0, y: 0, width: 0, height: 0, thickness: 0, color: .white, animate: true)),
        AnyView(RecursiveShape(num: 0, x: 0, y: 0, width: 0, height: 0, thickness: 0, color: .white, shape: AnyShape(Polygon(sides: 0)), animate: true))
    ]
    @State var SelectedShapeLayers:[ShapeView] = []
    @State var RandomParams = true
    @State var layerNumber = 0
    @State var backgroundColor = Color.white
    
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
            return "Razzle Dazzle"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Layers")) {
                    ForEach(SelectedShapeLayers.indices.reversed(), id: \.self) { index in
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
                                            Text("(Bottom Layer)").bold()
                                        }
                                        if index+1 == SelectedShapeLayers.count && SelectedShapeLayers.count > 1 {
                                            Text("(Top Layer)").bold()
                                        }
                                    }
                                    HStack(spacing: 0) {
                                        Text("Outline Color: ")
                                        Rectangle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(SelectedShapeLayers[index].View.color)
                                            .cornerRadius(4)
                                    }
                                }
                                Spacer()
                            }
                            .font(.system(.body, design: .monospaced))
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(6)
                        }
                    }
                    .onDelete { indexSet in
                        SelectedShapeLayers.remove(atOffsets: indexSet)
                    }
                }
                
                Section(header: Text("Shapes")) {
                    Button("Rectangles") {
                        layerNumber = layerNumber + 1
                        if RandomParams {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 0, View: ShapeStruct(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), width: Int.random(in: 1..<50), height: Int.random(in: 1..<50), diameter: Int.random(in: 1..<50), thickness: Int.random(in: 1..<10), color: Color.random, animate: true, polygonSides: Int.random(in: 1..<10)), LayerNumber: layerNumber))
                        } else {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 0, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 0, thickness: 2, color: .red, animate: true, polygonSides: 6), LayerNumber: layerNumber))
                        }
                    }
                    
                    Button("Circles") {
                        layerNumber = layerNumber + 1
                        if RandomParams {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), width: Int.random(in: 1..<50), height: Int.random(in: 1..<50), diameter: Int.random(in: 1..<50), thickness: Int.random(in: 1..<10), color: Color.random, animate: true, polygonSides: Int.random(in: 1..<10)), LayerNumber: layerNumber))
                        } else {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 1, View: ShapeStruct(num: 10, x: 0, y: 0, width: 0, height: 0, diameter: 10, thickness: 2, color: .green, animate: true, polygonSides: 6), LayerNumber: layerNumber))
                        }
                    }
                    
                    Button("Triangles") {
                        layerNumber = layerNumber + 1
                        if RandomParams {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 2, View: ShapeStruct(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), width: Int.random(in: 1..<50), height: Int.random(in: 1..<50), diameter: Int.random(in: 1..<50), thickness: Int.random(in: 1..<10), color: Color.random, animate: true, polygonSides: Int.random(in: 1..<10)), LayerNumber: layerNumber))
                        } else {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 2, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 10, thickness: 2, color: .blue, animate: true, polygonSides: 6), LayerNumber: layerNumber))
                        }
                    }
                    
                    Button("Polygons") {
                        layerNumber = layerNumber + 1
                        if RandomParams {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 3, View: ShapeStruct(num: Int.random(in: 1..<30), x: Int.random(in: -10..<10), y: Int.random(in: -10..<10), width: Int.random(in: 1..<50), height: Int.random(in: 1..<50), diameter: Int.random(in: 1..<50), thickness: Int.random(in: 1..<10), color: Color.random, animate: true, polygonSides: Int.random(in: 1..<10)), LayerNumber: layerNumber))
                        } else {
                            SelectedShapeLayers.append(ShapeView(ShapeValue: 3, View: ShapeStruct(num: 10, x: 0, y: 0, width: 10, height: 10, diameter: 10, thickness: 2, color: .yellow, animate: true, polygonSides: 6), LayerNumber: layerNumber))
                        }
                    }
                }
                
                Section(header: Text("Demo Art")) {
                    
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
                                layerNumber = 0
                                backgroundColor = Color.white
                            }
                        }
                    }
                }
                .listStyle(.sidebar)
        }
    }
}

struct ArtCanvas: View {
    @Binding var SelectedShapeLayers: [ShapeView]
    @Binding var BackgroundColor: Color
    var body: some View {
        ZStack {
            BackgroundColor.ignoresSafeArea()
            ForEach(SelectedShapeLayers, id: \.id) { layer in
                if layer.ShapeValue == 0 {
                    RecursiveRect(num: layer.View.num, x: layer.View.x, y: layer.View.y, width: layer.View.width, height: layer.View.height, thickness: layer.View.thickness, color: layer.View.color, animate: layer.View.animate)
                } else if layer.ShapeValue == 1 {
                    RecursiveCircle(num: layer.View.num, x: layer.View.x, y: layer.View.y, diameter: layer.View.diameter, thickness: layer.View.thickness, color: layer.View.color, animate: layer.View.animate)
                } else if layer.ShapeValue == 2 {
                    RecursiveTriangle(num: layer.View.num, x: layer.View.x, y: layer.View.y, width: layer.View.width, height: layer.View.height, thickness: layer.View.thickness, color: layer.View.color, animate: layer.View.animate)
                } else if layer.ShapeValue == 3 {
                    RecursiveShape(num: layer.View.num, x: layer.View.x, y: layer.View.y, width: layer.View.width, height: layer.View.height, thickness: layer.View.thickness, color: layer.View.color, shape: AnyShape(Polygon(sides: layer.View.polygonSides)), animate: layer.View.animate)
                }
            }
        }
    }
}

struct GenerateArtView: View {
    @Binding var SelectedShapeLayers: [ShapeView]
    @Binding var BackgroundColor: Color
    
    var body: some View {
        GeometryReader { geo in
        ArtCanvas(SelectedShapeLayers: $SelectedShapeLayers, BackgroundColor: $BackgroundColor)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button{
                    
//                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        }
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
//                    TextField("5", value: $ShapeView.View.num, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.num, shapeName: "Polygons", lowerBound: 1, upperBound: 30)
                }
                Section(header: Text("X Displacement")) {
//                    TextField("0", value: $ShapeView.View.x, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.x, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Y Displacement")) {
//                    TextField("0", value: $ShapeView.View.y, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.y, shapeName: "", lowerBound: -10, upperBound: 10)
                }
                Section(header: Text("Polygon Width")) {
//                    TextField("10", value: $ShapeView.View.width, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.width, shapeName: "", lowerBound: 1, upperBound: 50)
                }
                Section(header: Text("Polygon Height")) {
//                    TextField("10", value: $ShapeView.View.height, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.height, shapeName: "", lowerBound: 1, upperBound: 50)
                }
                Section(header: Text("Polygon Outline Thickness")) {
//                    TextField("2", value: $ShapeView.View.thickness, formatter: NumberFormatter())
                    IntSlider(value: $ShapeView.View.thickness, shapeName: "", lowerBound: 1, upperBound: 10)
                }
                Section(header: Text("Number of Sides")) {
//                    TextField("6", value: $ShapeView.View.polygonSides, formatter: NumberFormatter())
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
            }.navigationTitle(Text("Edit Polygon Layer"))
                .sheet(isPresented: $showPreview) {
                    RecursiveShape(num: ShapeView.View.num, x: ShapeView.View.x, y: ShapeView.View.y, width: ShapeView.View.width, height: ShapeView.View.height, thickness: ShapeView.View.thickness, color: ShapeView.View.color, shape: AnyShape(Polygon(sides: ShapeView.View.polygonSides)), animate: ShapeView.View.animate)
                }
        }
    }
}
