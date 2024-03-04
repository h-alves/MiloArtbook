//
//  RouterService.swift
//
//
//  Created by Henrique Semmer on 12/02/24.
//

import SwiftUI

class RouterService: ObservableObject {
    
    static var shared = RouterService()
    
    @Published var screen: Screen = .bug
    
    func navigate(_ screen: Screen) {
        self.screen = screen
    }
    
}
