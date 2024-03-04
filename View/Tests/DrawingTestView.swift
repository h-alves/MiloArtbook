import SwiftUI
import CoreML
import PencilKit
import UIKit

struct DrawingTestView: View {
    @State private var showImageSheet = false
    @State private var savedImage: UIImage?
    
    @State var canvas = PKCanvasView()
    @State var lineWidth: CGFloat = 20.0
    @State var canDraw = true
    
    var imageClassifier: HandDrawingClassifier?

    init() {
        do {
            imageClassifier = try HandDrawingClassifier(configuration: MLModelConfiguration())
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        ZStack {
            DrawingArea(canvas: $canvas, lineWidth: $lineWidth, canDraw: $canDraw)
            
            VStack {
                HStack(spacing: 48) {
                    Button {
                        canvas.drawing = PKDrawing()
                    } label: {
                        Image(systemName: "trash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    
                    Button {
                        let drawnImage = convertDrawingToImage()
                        saveImage(drawnImage)

                        savedImage = drawnImage
                    } label: {
                        Image(systemName: "folder.badge.plus")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    
                    Button {
                        showImageSheet = true
                    } label: {
                        Image(systemName: "tray.and.arrow.up")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.gray)
                
                Spacer()
            }
        }
        .sheet(isPresented: $showImageSheet) {
            if let savedImage = savedImage {
                VStack {
                    Image(uiImage: savedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    HStack {
                        Text("Teste")
                        
                        Button {
                            guard let pixelBuffer = savedImage.toCVPixelBuffer() else { return }

                            print("chegou aqui")

                            do {
                                let result = try imageClassifier?.prediction(image: pixelBuffer)
                                print("Resultado:")
                                
                                let dictionary = result?.targetProbability
                                
                                for (key, value) in dictionary! {
                                    let formattedValue = String(format: "%.2f", value)
                                    print("\(key) : \(formattedValue)")
                                }
                            } catch {
                                print(error)
                            }
                        } label: {
                            Text("Adivinhar")
                        }
                    }
                }
                .background(.blue)
            }
        }
    }
    
    func saveImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("drawnImage.jpg")
        
        do {
            try data.write(to: fileURL)
            print("Image saved at \(fileURL)")
        } catch {
            print("Error saving image: \(error)")
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

#Preview {
    DrawingTestView()
}

