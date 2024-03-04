//
//  ContentView.swift
//
//
//  Created by Henrique Semmer on 12/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var router = RouterService.shared
    
    var body: some View {
        VStack {
            switch(router.screen) {
            case .bug: BugView()
            case .menu: MenuView()
            case .initial: InitialCutsceneView()
            case .notebook: NotebookCutsceneView()
            case .earthCutscene: EarthCutsceneView()
            case .earth: EarthDrawingView()
            case .skyCutscene: SkyCutsceneView()
            case .sky: SkyDrawingView()
            case .last: LastCutsceneView()
                
            case .restart: RestartCutsceneView()
            case .infinite: InfiniteView()
                
            case .finish: FinishCutsceneView()
                
            case .drawingTest: DrawingTestView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
