//
//  SwiftUIView.swift
//  App
//
//  Created by mridul-ziroh on 21/03/25.
//

import SwiftUI

struct QuizView: View {
    @StateObject var viewModel = QuizViewModel()
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack {
                ForEach(viewModel.quizs, id: \.id){ quiz in
                    ExtractedView(quiz: quiz, viewModel: viewModel)
                }
                VStack{
                    ForEach(viewModel.quizs, id: \.id ) { quiz in
                        Text("\(quiz.id) --> \(quiz.answer == quiz.selectedOption)")
                            .padding()
                    }
                }
            }
        }
        .task{
            viewModel.fetchQuizes()
        }
    }
    
    struct ExtractedView: View {
        var quiz: Quiz
        var viewModel: QuizViewModel
        var body: some View {
            VStack {
                Text(quiz.question)
                    .font(.title)
                ForEach(quiz.options, id: \.self){ option in
                    Button {
                        viewModel.answer(quiz.id, option)
                    } label: {
                        Text(option)
                            .padding()
                            .border(.black)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
}

#Preview {
    QuizView()
}

