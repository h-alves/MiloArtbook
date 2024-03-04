//
//  Int.swift
//
//
//  Created by Henrique Semmer on 15/02/24.
//

import Foundation

extension Int {
    
    func addZero() -> String {
        
        if self < 10 {
            return "0\(self.description)"
        } else {
            return self.description
        }
    }
}
