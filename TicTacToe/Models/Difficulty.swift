//
//  Difficulty.swift
//  TicTacToe
//
//  Created by Johnny Sousa on 18/05/23.
//

import SwiftUI

enum Difficulty: CaseIterable {
    
    case easy
    case medium
    case hard
    
    var description: String {
        switch self {
        case .easy:
            return "Fácil"
        case .medium:
            return "Médio"
        case .hard:
            return "Difícil"
        }
    }
    
    var color: Color {
        switch self {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
}


extension Difficulty {
    
    func getStrategy(board: Board) -> DifficultyStrategy {
        switch self {
        case .easy:
            return EasyDifficultyStrategy(board: board)
        case .medium:
            return MediumDifficultyStrategy(board: board)
        case .hard:
            return HardDifficultyStrategy(board: board)
        }
    }
}
