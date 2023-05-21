//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Johnny Sousa on 18/05/23.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published private var board: Board
    
    init(difficulty: Difficulty) {
        self.board = Board(difficulty: difficulty)
    }
    
    func resetBoard() {
        board.resetBoard()
    }
    
    func makeMove(row: Int, col: Int) {
        guard !board.isGameOver() && board.currentPlayer == .X else {
            return
        }
        
        let move = Move(row: row, col: col)
        
        if board.makeMove(move) {
            makeMoveIA()
        }
    }
    
    func gameState() -> String {
        guard board.isGameOver() else {
            return "Jogador: \(board.currentPlayer.rawValue)"
        }
        
        if let winner = board.getWinner() {
            return "Jogador vencedor: \(winner.rawValue)"
        } else {
            return "Empate"
        }
    }
    
    func playerSymbol(row: Int, col: Int) -> String {
        return board.cells[row][col]?.rawValue ?? ""
    }
}

// MARK: - Private
extension GameViewModel {
    
    private func makeMoveIA() {
        guard !board.isGameOver() else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if let bestMove = self.board.findBestMove() {
                self.board.makeMove(bestMove)
            }
        }
    }
}
