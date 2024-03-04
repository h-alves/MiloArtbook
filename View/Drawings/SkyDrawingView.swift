//
//  SkyDrawingView.swift
//  
//
//  Created by Henrique Semmer on 12/02/24.
//

import SwiftUI
import PencilKit

struct SkyDrawingView: View {
    @ObservedObject var viewModel = DrawingViewModel()
    
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
            
            // Drawing Area
            ZStack {
                DrawingArea(canvas: $viewModel.canvas, lineWidth: $viewModel.lineWidth, canDraw: $viewModel.canDraw)
                    .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.81)
                    .background(.opacity(0.0))
                
                VStack {
                    // Top Bar
                    HStack(spacing: 18) {
                        Button {
                            // Erase drawing
                            viewModel.canvas.drawing = PKDrawing()
                        } label: {
                            Image(systemName: "trash.fill")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                        .disabled(!viewModel.canDraw)
                        
                        // Timer
                        Text("0:\(viewModel.totalTime.addZero())")
                            .font(.largeTitle)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                                .foregroundStyle(.opacity(0.0))
                        }
                        .disabled(!viewModel.canDraw)
                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.02)
                    .padding(.horizontal)
                    .padding(.bottom)
//                    .background(.yellow)
                    
                    Spacer()
                    
                    Button {
                        // Save and predict
                        viewModel.drawing = viewModel.convertDrawingToImage()
                        viewModel.predictImage(savedImage: viewModel.drawing!)
                        
                        // Disable drawing
                        viewModel.canDraw.toggle()
                        viewModel.cutscene.toggle()
                        viewModel.timer?.invalidate()
                    } label: {
                        Text("Finish")
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
                .frame(height: UIScreen.main.bounds.height * 0.81)
            }
            .padding(.bottom, UIScreen.main.bounds.height * 0.07)
            
            // Bottom Area
            ZStack {
                // Robot
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        if viewModel.loading {
                            Image("robot_loading")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.165, height: UIScreen.main.bounds.height * 0.22)
                                .padding(.trailing, UIScreen.main.bounds.width * 0.02)
                                .padding(.bottom, UIScreen.main.bounds.height * 0.008)
                                .foregroundStyle(.green)
                        } else {
                            if viewModel.sad {
                                Image("robot_sad")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.165, height: UIScreen.main.bounds.height * 0.22)
                                    .padding(.trailing, UIScreen.main.bounds.width * 0.02)
                                    .padding(.bottom, UIScreen.main.bounds.height * 0.008)
                            } else {
                                Image("robot_ML")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.165, height: UIScreen.main.bounds.height * 0.22)
                                    .padding(.trailing, UIScreen.main.bounds.width * 0.02)
                                    .padding(.bottom, UIScreen.main.bounds.height * 0.008)
                                    .foregroundStyle(.green)
                                    .onTapGesture {
                                        if viewModel.cutscene && viewModel.currentBalloon == 10  {
                                            // Mostrar sheet com resultado
                                            viewModel.cutscene.toggle()
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                viewModel.loading.toggle()
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                                viewModel.loading.toggle()
                                                viewModel.showImageSheet = true
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                
                // Speech Balloon
                if viewModel.cutscene {
                    if viewModel.question {
                        HStack {
                            Spacer()
                            
                            VStack {
                                Spacer()
                                
                                Image("balloon\(viewModel.currentBalloon)\(viewModel.aditional)")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.19)
                                    .foregroundStyle(.white)
                                
                                HStack(spacing: UIScreen.main.bounds.width * 0.03) {
                                    Button {
                                        viewModel.question.toggle()
                                        viewModel.currentBalloon += 1
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
                                                    .stroke(Color(UIColor.starDark()), lineWidth: 5)
                                            }
                                    }
                                    
                                    Button {
                                        viewModel.sad.toggle()
                                        viewModel.question.toggle()
                                        viewModel.currentBalloon += 1
                                        viewModel.aditional = ".5"
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
                                                    .stroke(Color(UIColor.starDark()), lineWidth: 5)
                                            }
                                    }
                                }
                                .padding(.trailing, UIScreen.main.bounds.width * 0.1)
                            }
                            .padding(.trailing, UIScreen.main.bounds.width * 0.09)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.13)
                        }
                    } else {
                        HStack {
                            Spacer()
                            
                            VStack {
                                Spacer()
                                
                                Image("balloon\(viewModel.currentBalloon)\(viewModel.aditional)")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.19)
                                    .foregroundStyle(.white)
                            }
                            .padding(.trailing, UIScreen.main.bounds.width * 0.09)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.21)
                        }
                    }
                } else if viewModel.loading {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .controlSize(.large)
                                .scaleEffect(UIScreen.main.bounds.width * 0.0007)
                                .padding(.trailing, UIScreen.main.bounds.width * 0.087)
                                .padding(.bottom, UIScreen.main.bounds.height * 0.05)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.screen = 2
            viewModel.setTimer()
        }
        .onTapGesture {
            if viewModel.currentBalloon >= 12 {
                RouterService.shared.navigate(.last)
            }
        }
        .sheet(isPresented: $viewModel.showImageSheet, onDismiss: {
            viewModel.currentBalloon += 1
            viewModel.cutscene.toggle()
            viewModel.question.toggle()
        }) {
            VStack {
                ZStack {
                    VStack {
                        Image("confidence")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.24, height: UIScreen.main.bounds.height * 0.04)
                        
                        // Stars
                        ZStack {
                            HStack(alignment: .bottom, spacing: UIScreen.main.bounds.width * -0.01) {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                    .foregroundStyle(viewModel.starsColors[0])
                                
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.09, height: UIScreen.main.bounds.height * 0.115)
                                    .foregroundStyle(viewModel.starsColors[1])
                                
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                    .foregroundStyle(viewModel.starsColors[2])
                            }
                            
                            HStack(alignment: .bottom, spacing: UIScreen.main.bounds.width * -0.01) {
                                Image(systemName: "star")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                    .foregroundStyle(Color(UIColor.starDark()))
                                
                                Image(systemName: "star")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.09, height: UIScreen.main.bounds.height * 0.115)
                                    .foregroundStyle(Color(UIColor.starDark()))
                                
                                Image(systemName: "star")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                    .foregroundStyle(Color(UIColor.starDark()))
                            }
                        }
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                                viewModel.rateDrawing()
                            }
                        }
                    }
                    
                    // Close Button
                    HStack {
                        Spacer()
                        
                        VStack {
                            Button {
                                viewModel.showImageSheet = false
                            } label: {
                                ZStack {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width * 0.038, height: UIScreen.main.bounds.height * 0.055)
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                    
                                    Image(systemName: "x.circle.fill")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width * 0.038, height: UIScreen.main.bounds.height * 0.055)
                                        .foregroundStyle(.red)
                                        .fontWeight(.bold)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.12)
                }
                
                Spacer()
                
                // Drawing Image
                ZStack {
                    // Saved Drawing
                    Rectangle()
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Image(uiImage: viewModel.drawing!)
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                    
                    // Drawing Label
                    VStack {
                        Image("\(viewModel.drawingLabel)")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.223, height: UIScreen.main.bounds.height * 0.119)
                        
                        Spacer()
                    }
//                    .padding(.top, UIScreen.main.bounds.height * 0.02)
                }
            }
            .padding(UIScreen.main.bounds.width * 0.02)
            .frame(maxHeight: .infinity)
            .background(Color(UIColor.wood()))
        }
    }
}

#Preview {
    SkyDrawingView()
}
