//
//  Canvas.swift
//  My App
//
//  Created by Henrique Semmer on 02/02/24.
//

import SwiftUI
import PencilKit

struct Canvas: View {
    @State var canvas = PKCanvasView()
    @State var lineWidth: CGFloat = 20.0
    @Binding var canDraw: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(alignment: .center) {
                    VStack(alignment: .center) {
                        DrawingArea(canvas: $canvas, lineWidth: $lineWidth, canDraw: $canDraw)
                            .frame(width: geometry.size.width * 0.76, height: geometry.size.height * 0.81)
                            .background(.yellow)
                    }
                    .frame(maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    func convertDrawingToImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: canvas.bounds.size)
        let image = renderer.image { (context) in
            UIColor.white.setFill()
            context.fill(canvas.bounds)
            
            canvas.drawHierarchy(in: canvas.bounds, afterScreenUpdates: true)
        }
        return image
    }
}

struct DrawingArea : UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var lineWidth: CGFloat
    @Binding var canDraw: Bool
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.backgroundColor = .clear
        canvas.tool = PKInkingTool(.pen, color: .black, width: lineWidth)
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // Atualize a largura da tinta enquanto desenha
        uiView.tool = PKInkingTool(.pen, color: .black, width: lineWidth)
        uiView.isUserInteractionEnabled = canDraw
    }
    
    private func initCanvas() -> Void {
        self.canvas = PKCanvasView();
        self.canvas.isOpaque = false
        self.canvas.backgroundColor = UIColor.clear
        self.canvas.becomeFirstResponder()
    }
}
