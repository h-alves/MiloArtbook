//
//  MenuView.swift
//  
//
//  Created by Henrique Semmer on 09/02/24.
//

import SwiftUI

struct MenuView: View {
    @State var notebook = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * 0.478)
    
    @State var clicked = false
    
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
            
            if !clicked {
                Button {
                    clicked.toggle()
                    
                    withAnimation(.linear(duration: 3.0)) {
                        notebook = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height * -0.5)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                        RouterService.shared.navigate(.initial)
                    }
                } label: {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width * 0.11, height: UIScreen.main.bounds.height * 0.08)
                        .foregroundStyle(.opacity(0.0))
                }
                .padding(.trailing, UIScreen.main.bounds.width * 0.03)
                .padding(.top, UIScreen.main.bounds.height * 0.33)
            }
        }
    }
}

#Preview {
    MenuView()
}
