//
//  DrawingViewModel.swift
//
//
//  Created by Henrique Semmer on 12/02/24.
//

import Foundation
import PencilKit
import CoreML
import SwiftUI

class DrawingViewModel: ObservableObject {
    
    // MARK: - drawing
    
    @Published var canvas = PKCanvasView()
    @Published var lineWidth: CGFloat = 20.0
    @Published var canDraw = true
    
    // MARK: - timer
    
    @Published var totalTime = 20
    @Published var timer: Timer?
    
    // MARK: - predict
    
    @Published var screen = 0
    @Published var drawing: UIImage?
    @Published var drawingLabel = ""
    @Published var drawingValue = 0.0
    
    // MARK: - dictionary
    
    @Published var key1 = ""
    @Published var key2 = ""
    @Published var value1 = 0.0
    @Published var value2 = 0.0
    
    // MARK: - other
    
    @Published var sad = false
    @Published var currentBalloon = 10
    @Published var aditional = ""
    @Published var question = false
    
    @Published var cutscene = false
    @Published var loading = false
    @Published var showImageSheet = false
    
    @Published var starsColors: [Color] = [Color(UIColor.starDark()), Color(UIColor.starDark()), Color(UIColor.starDark())]
    
    @Published var imageClassifier: HandDrawingClassifier?

    init() {
        do {
            imageClassifier = try HandDrawingClassifier(configuration: MLModelConfiguration())
        } catch {
            print(error)
        }
    }
    
    // MARK: - drawing
    
    func convertDrawingToImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: canvas.bounds.size)
        let image = renderer.image { (context) in
            UIColor.white.setFill()
            context.fill(canvas.bounds)
            
            canvas.drawHierarchy(in: canvas.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    func predictImage(savedImage: UIImage) {
        guard let pixelBuffer = savedImage.toCVPixelBuffer() else { return }

        do {
            let result = try imageClassifier?.prediction(image: pixelBuffer)
            print("Resultado:")
            
            let dictionary = result?.targetProbability
            
            for (key, value) in dictionary! {
                let formattedValue = String(format: "%.2f", value)
                let realValue = value * 100
                print("\(key) : \(formattedValue)")
                
                if screen == 1 {
                    key1 = "Tree"
                    key2 = "House"
                } else if screen == 2 {
                    key1 = "Sun"
                    key2 = "Cloud"
                }
                
                if key == key1 {
                    value1 = realValue
                } else if key == key2 {
                    value2 = realValue
                }
            }
            
            if value1 > value2 {
                drawingLabel = key1.lowercased()
                drawingValue = value1
            } else {
                drawingLabel = key2.lowercased()
                drawingValue = value2
            }
        } catch {
            print(error)
        }
    }
    
    func rateDrawing() {
        if drawingValue > 35 {
            withAnimation {
                starsColors[0] = Color(UIColor.star())
            }
        }
        if drawingValue > 50 {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                withAnimation {
                    self.starsColors[1] = Color(UIColor.star())
                }
            }
        }
        if drawingValue > 95 {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                withAnimation {
                    self.starsColors[2] = Color(UIColor.star())
                }
            }
        }
    }
    
    // MARK: - timer
    
    func setTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            if self.totalTime > 0 {
                self.totalTime -= 1
            } else {
                drawing = convertDrawingToImage()
                predictImage(savedImage: convertDrawingToImage())
                canDraw.toggle()
                cutscene.toggle()
                timer.invalidate()
            }
        }
    }
}
