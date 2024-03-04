//
//  NotebookCutsceneView.swift
//  
//
//  Created by Henrique Semmer on 14/02/24.
//

import SwiftUI

struct NotebookCutsceneView: View {
    @State var position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * -0.5)
    @State var animation = true
    
    @State var currentBalloon = 5
    
    var body: some View {
        ZStack {
            // Background Image
            Rectangle()
                .foregroundStyle(Color(UIColor.background()))
                .ignoresSafeArea()
            
            // Notebook Image
            Image("notebook1")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.87, height: UIScreen.main.bounds.height * 0.91)
                .position(position)
                .foregroundStyle(.red)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.linear(duration: 3)) {
                            position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * 0.478)
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
                        currentBalloon += 1
                        animation.toggle()
                    }
                }
            
            // Bottom Area
            ZStack {
                // Robot
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Image("robot_ML")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.165, height: UIScreen.main.bounds.height * 0.22)
                            .padding(.trailing, UIScreen.main.bounds.width * 0.02)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.008)
                            .foregroundStyle(.green)
                    }
                }
                
                // Speech Balloon
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Image("balloon\(currentBalloon)")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.19)
                            .padding(.trailing, UIScreen.main.bounds.width * 0.09)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.21)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .onTapGesture {
            if !animation {
                if currentBalloon < 5 {
                    currentBalloon += 1
                } else {
                    RouterService.shared.screen = .earthCutscene
                }
            }
        }
    }
}

#Preview {
    NotebookCutsceneView()
}
