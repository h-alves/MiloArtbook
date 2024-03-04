//
//  FinishCutsceneView.swift
//
//
//  Created by Henrique Semmer on 23/02/24.
//

import SwiftUI

struct FinishCutsceneView: View {
    @State var notebook = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * -0.5)
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color(UIColor.background()))
                .ignoresSafeArea()
            
            Image("robot_ML")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.26, height: UIScreen.main.bounds.height * 0.35)
                .position(CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
            
            Image("notebookCover")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.435, height: UIScreen.main.bounds.height * 0.91)
                .position(notebook)
        }
        .onAppear {
            withAnimation(.linear(duration: 3.0)) {
                notebook = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * 0.478)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                RouterService.shared.navigate(.menu)
            }
        }
    }
}

#Preview {
    FinishCutsceneView()
}
