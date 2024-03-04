//
//  SkyCutsceneView.swift
//
//
//  Created by Henrique Semmer on 14/02/24.
//

import SwiftUI

struct SkyCutsceneView: View {
    @State var position = CGPoint(x: UIScreen.main.bounds.width * 1.5, y: UIScreen.main.bounds.height * 0.22)
    @State var choosing = false
    @State var balloon = true
    
    @State var currentBalloon = 13
    
    var body: some View {
        ZStack {
            // Background Image
            Rectangle()
                .foregroundStyle(Color(UIColor.background()))
                .ignoresSafeArea()
            
            // Notebook Image
            Image("notebook3")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.87, height: UIScreen.main.bounds.height * 0.91)
                .foregroundStyle(.red)
            
            if choosing {
                VStack {
                    VStack(spacing: 48) {
                        Image("choose2")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.13)
                            .padding(.top, UIScreen.main.bounds.height * 0.05)
                            .padding(.leading, UIScreen.main.bounds.width * 0.03)
                        
                        Button {
                            RouterService.shared.navigate(.sky)
                        } label: {
                            Text("Start")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                                .padding()
                                .background(Color(UIColor.star()))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(UIColor.starDark()), lineWidth: 5)
                                }
                        }
                    }
                    
                    Spacer()
                }
            }
            
            // Bottom Area
            ZStack {
                // Robot
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        if choosing {
                            Image("robot_eyes")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.165, height: UIScreen.main.bounds.height * 0.22)
                                .padding(.trailing, UIScreen.main.bounds.width * 0.02)
                                .padding(.bottom, UIScreen.main.bounds.height * 0.008)
                                .foregroundStyle(.green)
                        } else {
                            Image("robot_ML")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.165, height: UIScreen.main.bounds.height * 0.22)
                                .padding(.trailing, UIScreen.main.bounds.width * 0.02)
                                .padding(.bottom, UIScreen.main.bounds.height * 0.008)
                                .foregroundStyle(.green)
                        }
                    }
                }
                
                // Speech Balloon
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        if balloon {
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
        }
        .onTapGesture {
            if currentBalloon == 13 {
                currentBalloon = 8
                choosing.toggle()
            } else {
                if !choosing {
                    RouterService.shared.screen = .sky
                }
            }
        }
    }
}

#Preview {
    SkyCutsceneView()
}
