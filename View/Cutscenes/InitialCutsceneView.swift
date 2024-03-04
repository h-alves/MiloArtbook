//
//  InitialCutsceneView.swift
//  
//
//  Created by Henrique Semmer on 14/02/24.
//

import SwiftUI

struct InitialCutsceneView: View {
    @State var position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    @State var lastPosition = CGPoint(x: UIScreen.main.bounds.width * 1.132, y: UIScreen.main.bounds.height * 1.05)
    @State var scale = 1.0
    @State var animation = false
    
    @State var currentBalloon = 1
    
    var body: some View {
        ZStack {
            // Background Image
            Rectangle()
                .foregroundStyle(Color(UIColor.background()))
                .ignoresSafeArea()
            
            ZStack {
                // Robot
                Image("robot_ML")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.26, height: UIScreen.main.bounds.height * 0.35)
                    .position(position)
                    .scaleEffect(scale)
                    .foregroundStyle(.green)
                
                if !animation {
                    // Speech Balloon
                    Image("balloon\(currentBalloon)")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.46, height: UIScreen.main.bounds.height * 0.26)
                        .padding(.trailing, UIScreen.main.bounds.width * 0.49)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.47)
                        .foregroundStyle(.white)
                }
            }
        }
        .onTapGesture {
            if !animation {
                if currentBalloon < 4 {
                    currentBalloon += 1
                } else {
                    animation.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.linear(duration: 3)) {
                            position = lastPosition
                            scale = 0.63
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        RouterService.shared.screen = .notebook
                    }
                }
            }
        }
    }
}

#Preview {
    InitialCutsceneView()
}
