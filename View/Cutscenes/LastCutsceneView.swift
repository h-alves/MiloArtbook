//
//  LastCutsceneView.swift
//
//
//  Created by Henrique Semmer on 19/02/24.
//

import SwiftUI

struct LastCutsceneView: View {
    @State var position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    @State var lastPosition = CGPoint(x: UIScreen.main.bounds.width * 1.132, y: UIScreen.main.bounds.height * 1.05)
    @State var scale = 0.63
    @State var animation = true
    
    @State var notebook = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * 0.478)
    
    @State var currentBalloon = 14
    
    @State var question = false
    
    var body: some View {
        ZStack {
            // Background Image
            Rectangle()
                .foregroundStyle(Color(UIColor.background()))
                .ignoresSafeArea()
            
            // Notebook Image
            Image("notebook4")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.87, height: UIScreen.main.bounds.height * 0.91)
                .position(notebook)
                .foregroundStyle(.red)
            
            ZStack {
                // Robot
                Image("robot_ML")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.26, height: UIScreen.main.bounds.height * 0.35)
                    .position(lastPosition)
                    .scaleEffect(scale)
                    .foregroundStyle(.green)
                
                if !animation {
                    // Speech Balloon
                    if question {
                        VStack {
                            Image("balloon\(currentBalloon)")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.46, height: UIScreen.main.bounds.height * 0.26)
                                .foregroundStyle(.white)
                            
                            HStack(spacing: UIScreen.main.bounds.width * 0.03) {
                                Button {
                                    question.toggle()
                                    currentBalloon = 19
                                } label: {
                                    Text("Yes")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black)
                                        .padding(.vertical, UIScreen.main.bounds.height * 0.02)
                                        .padding(.horizontal, UIScreen.main.bounds.width * 0.015)
                                        .background(Color(UIColor.star()))
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(UIColor.black), lineWidth: 5)
                                        }
                                }
                                
                                Button {
                                    question.toggle()
                                    currentBalloon = 18
                                } label: {
                                    Text("No")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black)
                                        .padding(.vertical, UIScreen.main.bounds.height * 0.02)
                                        .padding(.horizontal, UIScreen.main.bounds.width * 0.015)
                                        .background(Color(UIColor.star()))
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(UIColor.black), lineWidth: 5)
                                        }
                                }
                            }
                            .padding(.trailing, UIScreen.main.bounds.width * 0.24)
                        }
                        .padding(.trailing, UIScreen.main.bounds.width * 0.49)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.39)
                    } else {
                        Image("balloon\(currentBalloon)")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.46, height: UIScreen.main.bounds.height * 0.26)
                            .padding(.trailing, UIScreen.main.bounds.width * 0.49)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.47)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.linear(duration: 3)) {
                    notebook = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * -0.5)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.6) {
                withAnimation(.linear(duration: 2)) {
                    lastPosition = position
                    scale = 1.0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.7) {
                animation = false
            }
        }
        .onTapGesture {
            if !animation {
                if currentBalloon == 18 {
                    RouterService.shared.navigate(.finish)
                } else if currentBalloon == 19 {
                    RouterService.shared.navigate(.restart)
                }
                currentBalloon += 1
                if currentBalloon == 17 {
                    question.toggle()
                }
            }
        }
    }
}

#Preview {
    LastCutsceneView()
}
