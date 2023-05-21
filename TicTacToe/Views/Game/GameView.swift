import SwiftUI

struct GameView: View {
    
    @StateObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text("Jogo da Velha")
                .font(.largeTitle)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                ForEach(0..<3, id: \.self) { row in
                    ForEach(0..<3, id: \.self) { column in
                        Button(action: {
                            viewModel.makeMove(row: row, col: column)
                        }) {
                            Text(viewModel.playerSymbol(row: row, col: column))
                                .font(.largeTitle)
                                .frame(width: 80, height: 80)
                                .foregroundColor(.black)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            
            Text(viewModel.gameState())
                .font(.title)
                .padding()
            
            Button(action: {
                viewModel.resetBoard()
            }) {
                Text("Reiniciar Jogo")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(difficulty: .easy))
    }
}
