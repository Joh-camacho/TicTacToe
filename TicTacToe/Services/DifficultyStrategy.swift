//
//  DifficultyStrategy.swift
//  TicTacToe
//
//  Created by Johnny Sousa on 18/05/23.
//

import Foundation

protocol DifficultyStrategy {
    
    var board: Board { get }
    
    func findBestMove() -> Move?
    
}

struct EasyDifficultyStrategy: DifficultyStrategy {
    
    let board: Board
    
    init(board: Board) {
        self.board = board
    }
    
    func findBestMove() -> Move? {
        return board.availableMoves().randomElement()
    }
}

struct MediumDifficultyStrategy: DifficultyStrategy {
    
    let board: Board
    
    init(board: Board) {
        self.board = board
    }
    
    func findBestMove() -> Move? {
        var bestMove: Move?
        var bestEval = Int.min
        
        for move in board.availableMoves() {
            var newBoard = board
            newBoard.makeMove(move)
            
            let eval = minimax(board: newBoard, depth: 9, maximizingPlayer: false)
            
            if eval > bestEval {
                bestEval = eval
                bestMove = move
            }
        }
        
        return bestMove
    }
    
    private func minimax(board: Board, depth: Int, maximizingPlayer: Bool) -> Int {
        if depth == 0 || board.isGameOver() {
            return board.evaluate()
        }
        
        if maximizingPlayer {
            var maxEval = Int.min
            
            for move in board.availableMoves() {
                var newBoard = board
                newBoard.makeMove(move)
                
                let eval = minimax(board: newBoard, depth: depth - 1, maximizingPlayer: false)
                
                maxEval = max(maxEval, eval)
            }
            
            return maxEval
        } else {
            var minEval = Int.max
            for move in board.availableMoves() {
                var newBoard = board
                newBoard.makeMove(move)
                
                let eval = minimax(board: newBoard, depth: depth - 1, maximizingPlayer: true)
               
                minEval = min(minEval, eval)
            }
            
            return minEval
        }
    }
}

struct HardDifficultyStrategy: DifficultyStrategy {
    
    let board: Board
    
    init(board: Board) {
        self.board = board
    }
    
    func findBestMove() -> Move? {
        var bestScore = Int.min
        var bestMove: Move?
        
        for move in board.availableMoves() {
            var newBoard = board
            newBoard.makeMove(move)
            
            let score = minimax(board: newBoard, depth: 9, alpha: Int.min, beta: Int.max, maximizingPlayer: false)
            
            if score > bestScore {
                bestScore = score
                bestMove = move
            }
        }
        
        return bestMove
    }
    
    private func minimax(board: Board, depth: Int, alpha: Int, beta: Int, maximizingPlayer: Bool) -> Int {
        if depth == 0 || board.isGameOver() {
            return board.evaluate()
        }
        
        var alpha = alpha
        var beta = beta
        
        if maximizingPlayer {
            var maxEval = Int.min
            
            for move in board.availableMoves() {
                var newBoard = board
                newBoard.makeMove(move)
                
                let eval = minimax(board: newBoard, depth: depth - 1, alpha: alpha, beta: beta, maximizingPlayer: false)
                
                maxEval = max(maxEval, eval)
                alpha = max(alpha, eval)
                
                if beta <= alpha {
                    break
                }
            }
            
            return maxEval
        } else {
            var minEval = Int.max
            
            for move in board.availableMoves() {
                var newBoard = board
                newBoard.makeMove(move)
                
                let eval = minimax(board: newBoard, depth: depth - 1, alpha: alpha, beta: beta, maximizingPlayer: true)
                
                minEval = min(minEval, eval)
                beta = min(beta, eval)
                
                if beta <= alpha {
                    break
                }
            }
            
            return minEval
        }
    }
}
