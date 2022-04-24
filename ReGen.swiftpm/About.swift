//
//  About.swift
//  ReGen
//
//  Created by Don Chia on 15/4/22.
//

import SwiftUI

struct About: View {
    var body: some View {
        ScrollView {
        VStack(alignment: .leading, spacing: 10) {
            Text("Re:Gen")
                .font(.system(.largeTitle, design: .monospaced))
                .bold()
            Text("There is no right or wrong way to be a generative artist. There are no rules or recipes. Generative art is about the organic, the emergent, the beautiful, the imprecise, and the unexpected.\n- Matt Pearson (Generative Art: A Practical Guide Using Processing)")
                .font(.system(.footnote, design: .monospaced))
                .padding(.bottom)
            
            Text("About")
                .font(.system(.title, design: .monospaced))
                .bold()
            Text("I have always been fascinated by the concept of recursion ever since I stumbled across the concept. For most computer scientists, the idea of recursion often entails making use of functions that calls itself, breaking down the problem into a smaller, simpler version of itself. This is often applied by solving factorials recursively or calculating a certain number of fibonacci's sequence. However, many computer scientists overlook the idea of applying recursion for generative art. This interesting concept of recursive art follows the concept of recursion closely, a shape is generated recursively with a function, creating a sequence of neat shapes that follow a specific pattern.")
                .font(.system(.body, design: .monospaced))
                .padding(.bottom)
            
            Text("How It Works")
                .font(.system(.title, design: .monospaced))
                .bold()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("FUNCTION GENERATE_SHAPE (NUM: INTEGER, WIDTH: INTEGER, HEIGHT: INTEGER) {")
                    Text("  IF NUM == 0 {")
                    Text("      RETURN SHAPE WITH ZERO WIDTH AND HEIGHT")
                    Text("  }")
                    Text("  ELSE {")
                }
                Text("      ZSTACK {")
                Text("          SHAPE WITH WIDTH: NUM * WIDTH AND HEIGHT: NUM * HEIGHT")
                Text("          RETURN GENERATE_SHAPE(NUM: NUM-1, WIDTH: WIDTH, HEIGHT: HEIGHT)").foregroundColor(.red)
                Text("      }")
                Text("  }")
                Text("}")
            }.font(.system(.body, design: .monospaced))
            
            VStack {
                Text("The pseudocode of a simplified version of the shape generating function is presented as above. The function is simple in nature and that is the beauty of recursion, the recursive line is highlighted in red and that specific line of code is called to generate the next shape recursively.")
                    .font(.system(.body, design: .monospaced))
            }.padding(.bottom)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Supremus")
                    .font(.system(.title, design: .monospaced))
                    .bold()
                
                Text("Supremus was an abstract art movement formed in early 20th century Russia by a group of artists who believed in making use of basic shapes and colours to create artworks. The movement rejected the depiction of objects and instead aimed to reach an extreme point beyond which art could no longer be considered art.")
                    .font(.system(.body, design: .monospaced))
                Text("With Re:Gen, one can easily make pieces in the style of Supremus as the playground app heavily depends on the use of geometric shapes. The use of recursion also introduces the flaw of gaps between outline and also the possibility of displacement between each shape in the X or Y axis, a flaw that can be seen as a modern generative take on the century-old movement.")
                    .font(.system(.body, design: .monospaced))
                Text("To create artworks in the style of the Supremus movement, simply make use of any of the geometric shapes and lay them out by dragging the shapes around the canvas, create a flow in each piece and explore each shape and the parameters that can be tweaked, there is nothing wrong with breaking the rules of an art movement.")
                    .font(.system(.body, design: .monospaced))
            }.padding(.bottom)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Tips and Tricks for Creating Generative Art on Re:Gen")
                    .font(.system(.title, design: .monospaced))
                    .bold()
                
                Text("- Make use of the Random Parameter option! This allows the app to randomly select values for a shape, it might just generate and interesting recursive pattern that you could use. Activate the option and then click on an available shape, this will generate a shape with random parameters.")
                    .font(.system(.body, design: .monospaced))
                Text("- Try sticking to one kind of shape first, a simple generative art can start with few elements of the same type. If this is your first time, try enabling Random Parameter option and selecting 1 to 5 circle elements before generating the art. The end result will always be random and interesting to look at.")
                    .font(.system(.body, design: .monospaced))
                Text("- Change your background color and play around with each shape's outline color! Find a good matchup or just randomize it!")
                    .font(.system(.body, design: .monospaced))
                Text("- If you're planning to create pattern art, play around with the sliders in each shape and plan out the end product.")
                    .font(.system(.body, design: .monospaced))
            }
            Spacer()
        }.padding()
    }
}
}
