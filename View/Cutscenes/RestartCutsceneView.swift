//
//  RestartCutsceneView.swift
//  
//
//  Created by Henrique Semmer on 23/02/24.
//

import SwiftUI

struct RestartCutsceneView: View {
    @State var position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    @State var lastPosition = CGPoint(x: UIScreen.main.bounds.width * 1.132, y: UIScreen.main.bounds.height * 1.05)
    @State var scale = 1.0
    @State var animation = false
    
    @State var notebook = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * -0.5)
    
    var body: some View {
        ZStack {
            // Background Image
            Rectangle()
                .foregroundStyle(Color(UIColor.background()))
                .ignoresSafeArea()
            
            Image("notebook4")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.87, height: UIScreen.main.bounds.height * 0.91)
                .position(notebook)
            
            ZStack {
                // Robot
                Image("robot_ML")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.26, height: UIScreen.main.bounds.height * 0.35)
                    .position(position)
                    .scaleEffect(scale)
                    .foregroundStyle(.green)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 3)) {
                    position = lastPosition
                    scale = 0.63
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.linear(duration: 3)) {
                    notebook = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * 0.478)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
                RouterService.shared.navigate(.infinite)
            }
        }
    }
}

#Preview {
    RestartCutsceneView()
}
