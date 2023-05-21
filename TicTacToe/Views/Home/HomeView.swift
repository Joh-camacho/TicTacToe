//
//  HomeView.swift
//  TicTacToe
//
//  Created by Johnny Sousa on 18/05/23.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Escolha a dificuldade")
                    .font(.largeTitle)
                    .padding()
                
                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    NavigationLink(destination: {
                        GameView(viewModel: GameViewModel(difficulty: difficulty))
                    }) {
                        Text(difficulty.description)
                            .frame(width: 200)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(difficulty.color)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
