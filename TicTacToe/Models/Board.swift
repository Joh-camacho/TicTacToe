//
//  Board.swift
//  TicTacToe
//
//  Created by Johnny Sousa on 18/05/23.
//

import Foundation

struct Board {
    
    let difficulty: Difficulty
    
    var currentPlayer: Player = .X
    var cells: [[Player?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    
    init(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
    
    mutating func resetBoard() {
        self.currentPlayer = .X
        self.cells = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    }
    
    @discardableResult
    mutating func makeMove(_ move: Move) -> Bool {
        guard cells[move.row][move.col] == nil else {
            return false
        }
        
        cells[move.row][move.col] = currentPlayer
        currentPlayer = currentPlayer == .X ? .O : .X
        
        return true
    }
    
    func findBestMove() -> Move? {
        let strategy = difficulty.getStrategy(board: self)
        
        return strategy.findBestMove()
    }
    
    func availableMoves() -> [Move] {
        var availableMoves: [Move] = []
        
        for row in 0..<3 {
            for col in 0..<3 {
                if cells[row][col] == nil {
                    let move = Move(row: row, col: col)
                    
                    availableMoves.append(move)
                }
            }
        }
        
        return availableMoves
    }
    
    func isGameOver() -> Bool {
        return getWinner() != nil || isBoardFull()
    }
    
    func getWinner() -> Player? {
        if checkRows() || checkColumns() || checkDiagonals() {
            return currentPlayer == .X ? .O : .X
        } else {
            return nil
        }
    }
    
    func evaluate() -> Int {
        if checkRows() || checkColumns() || checkDiagonals() {
            return currentPlayer == .X ? 1 : -1
        } else {
            return 0
        }
    }
}

// MARK: - Private
extension Board {
 
    private func checkRows() -> Bool {
        for row in 0..<3 {
            if let player = cells[row][0], cells[row][1] == player, cells[row][2] == player {
                return true
            }
        }
        return false
    }
    
    private func checkColumns() -> Bool {
        for col in 0..<3 {
            if let player = cells[0][col], cells[1][col] == player, cells[2][col] == player {
                return true
            }
        }
        return false
    }
    
    private func checkDiagonals() -> Bool {
        if let player = cells[0][0], cells[1][1] == player, cells[2][2] == player {
            return true
        }
        
        if let player = cells[2][0], cells[1][1] == player, cells[0][2] == player {
            return true
        }
        
        return false
    }
    
    private func isBoardFull() -> Bool {
        return availableMoves().isEmpty
    }
}
