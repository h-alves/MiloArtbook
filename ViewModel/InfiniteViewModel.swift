//
//  InfiniteViewModel.swift
//
//
//  Created by Henrique Semmer on 22/02/24.
//

import Foundation
import PencilKit
import CoreML
import SwiftUI

class InfiniteViewModel: ObservableObject {
    
    // MARK: - drawing
    
    @Published var canvas = PKCanvasView()
    @Published var lineWidth: CGFloat = 20.0
    @Published var canDraw = true
    
    @Published var prompts = ["tree", "house", "sun", "cloud"]
    @Published var prompt = ""
    
    // MARK: - prediction
    
    @Published var drawing: UIImage?
    @Published var drawingLabel = ""
    @Published var drawingValue = 0.0
    
    // MARK: - other
    
    @Published var sad = false
    @Published var currentBalloon = 10
    @Published var aditional = ""
    @Published var question = false
    
    @Published var nothing = false
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
            
            var biggerValue = 0.0
            
            for (key, value) in dictionary! {
                let formattedValue = String(format: "%.2f", value)
                let realValue = value * 100
                print("\(key) : \(formattedValue)")
                
                if realValue > biggerValue {
                    biggerValue = realValue
                    drawingLabel = key.lowercased()
                    drawingValue = realValue
                }
                print(drawingLabel)
                
                if drawingLabel == "nothing" {
                    nothing = true
                } else {
                    nothing = false
                }
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
    
    // MARK: - prompt
    
    func changeDrawing() {
        var newPrompt = prompt
        
        while newPrompt == prompt {
            newPrompt = prompts.randomElement()!
        }
        
        prompt = newPrompt
        nothing = false
        aditional = ""
        currentBalloon = 10
    }
}
